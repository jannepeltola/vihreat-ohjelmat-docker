# Stage 1: build image
FROM node:22-bookworm AS build-base

# Install Rust
# GCC needed for some packages
RUN apt update
RUN apt install -y gcc lld libpango1.0-dev
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python, required by atomic-server build deps and JSON conversion
RUN apt install -y python3 

# Install pnpm with corepack
RUN corepack enable && corepack prepare pnpm@latest --activate
ENV PNPM_HOME=/usr/local/bin

# Set up Atomic Server
ENV ATOMIC_DATA_DIR="/atomic-storage/data"
ENV ATOMIC_CONFIG_DIR="/atomic-storage/config"
ENV ATOMIC_PORT="9883"
COPY ./atomic-server/ /app/atomic-server/
WORKDIR /app/atomic-server
RUN cargo build
WORKDIR /app/atomic-server/browser/lib
RUN pnpm install
RUN pnpm run build
WORKDIR /app/atomic-server/browser/react
RUN pnpm install
RUN pnpm run build
WORKDIR /app/atomic-server/browser/cli
RUN pnpm install
RUN pnpm run build

# Generate ontologies
COPY ./vihreat-data/ /app/vihreat-data/
WORKDIR /app/vihreat-data
RUN python3 generate.py
RUN bash import-data.sh

# Set up vihreat-lib
COPY ./vihreat-lib/ /app/vihreat-lib/
WORKDIR /app/vihreat-lib
RUN pnpm install
WORKDIR /app/vihreat-data
RUN bash generate-types.sh
WORKDIR /app/vihreat-lib
RUN pnpm run build

# Set up vihreat-ohjelmat
COPY ./vihreat-ohjelmat/ /app/vihreat-ohjelmat/
WORKDIR /app/vihreat-ohjelmat
RUN pnpm install
RUN pnpm build

FROM nginx:mainline AS ohjelmat
COPY --from=build-base /app/vihreat-ohjelmat/dist/ /usr/share/nginx/html
EXPOSE 80

FROM buildpack-deps:bookworm AS server
RUN mkdir /app
COPY --from=build-base /app/atomic-server/target/debug/atomic-server /app
COPY --from=build-base /app/vihreat-data/ad-export.json /app
COPY --chmod=755 ./atomic-entrypoint.sh /app

ENV ATOMIC_DATA_DIR="/atomic-storage/data"
ENV ATOMIC_CONFIG_DIR="/atomic-storage/config"
ENV ATOMIC_PORT="9883"
EXPOSE 9883
VOLUME /atomic-storage
ENTRYPOINT ["/bin/bash", "-c", "/app/atomic-entrypoint.sh"]

# TODO: Fix import