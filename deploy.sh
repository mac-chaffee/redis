#!/usr/bin/env bash
set -Eeuo pipefail

gcloud beta compute --project "personal-projects-244723" scp src/redis-server --zone "us-central1-c" "redis-over-http":/home/mac
gcloud beta compute --project "personal-projects-244723" scp redis.conf --zone "us-central1-c" "redis-over-http":/home/mac


# Run this to connect: 
# gcloud beta compute ssh --zone "us-central1-c" "redis-over-http" --project "personal-projects-244723"
