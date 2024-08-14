#!/bin/bash

docker build --tag=vihreat-ohjelmat-atomic --target=server -m 4g .
docker build --tag=vihreat-ohjelmat-app --target=ohjelmat -m 4g .