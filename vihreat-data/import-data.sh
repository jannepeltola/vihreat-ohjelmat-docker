#!/bin/bash
set -e

# Import bootstrap data
bash server.sh import --file ./json/ontology.json
for file in ./json/p*.json
do 
    bash server.sh import --file $file
done

# Export final AD JSON
bash server.sh export -p /app/vihreat-data/ad-export.json
