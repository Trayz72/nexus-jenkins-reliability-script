#!/bin/bash
set -e

# Configuration
NEXUS_BASE="http://${NEXUS_IP}:8081/service/rest/v1/search/assets/download"
AUTH="-u $NEXUS_USER:$NEXUS_PASS"

mkdir -p /root/app_deploy && cd /root/app_deploy

echo "Downloading latest backend..."
curl $AUTH -L "${NEXUS_BASE}?repository=spring-boot-repo&maven.extension=jar&sort=version&direction=desc" 

echo "Downloading latest frontend..."
curl $AUTH -L "${NEXUS_BASE}?repository=angular-app-repo&sort=version&direction=desc" 

echo "Deployment complete."