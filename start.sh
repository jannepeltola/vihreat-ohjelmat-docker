#!/bin/bash
bash build_containers.sh
docker-compose -f stack-dev.yml up