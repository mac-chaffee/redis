#!/usr/bin/env bash
set -Eeuo pipefail

# Upload files
for filename in "src/redis-server" "src/redis-cli" "redis.conf" "homepage.html" "redis.service"; do
    gcloud beta compute --project "personal-projects-244723" scp $filename --zone "us-central1-c" "redis-over-http":/home/mac &
done
wait
# Generate password
PASSWORD=$(openssl rand -hex 24)
gcloud beta compute ssh --zone "us-central1-c" "redis-over-http" --project "personal-projects-244723" --command="sed -i 's/somesecurepassword/$PASSWORD/g' redis.conf"
# Restart redis


# Run this to connect: 
# gcloud beta compute ssh --zone "us-central1-c" "redis-over-http" --project "personal-projects-244723"

# Run this to load the homepage
# grep 'user mac' redis.conf
# cat homepage.html | ./redis-cli -p 80 -x --user mac --pass $PASSWORD set /

# Run this to get the IP
# gcloud compute instances list --filter="name=redis-over-http" --format "get(networkInterfaces[0].accessConfigs[0].natIP)"
