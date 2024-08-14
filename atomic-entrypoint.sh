#!/bin/bash

/app/atomic-server import --force --file /app/ad-export.json
rm /app/ad-export.json
/app/atomic-server