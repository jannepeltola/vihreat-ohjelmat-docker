#!/bin/bash
set -e

# Start atomic-server in the background
source with-atomic-server-in-background.sh
sleep 5
cd /app/vihreat-lib
pnpm run generate-ontologies