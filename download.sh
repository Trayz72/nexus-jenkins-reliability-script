#!/bin/bash

VERSION=$1
# We expect these to be provided by the shell environment
# NEXUS_USER and NEXUS_PASS will be passed by Jenkins
NEXUS_IP="192.168.1.XX" 
NEXUS_URL="http://${NEXUS_IP}:8081/repository"

echo "Deploying version: $VERSION to $(hostname)"

mkdir -p ~/app_deploy && cd ~/app_deploy

# Use the environment variables instead of hardcoded strings
curl -u "${NEXUS_USER}:${NEXUS_PASS}" -L \
    "${NEXUS_URL}/spring-boot-repo/com/myapp/backend/${VERSION}/backend-${VERSION}.jar" \
    -o backend.jar

curl -u "${NEXUS_USER}:${NEXUS_PASS}" -L \
    "${NEXUS_URL}/angular-app-repo/frontend-${VERSION}.tar.gz" \
    -o frontend.tar.gz

tar -xzf frontend.tar.gz && rm frontend.tar.gz

echo "Artifacts downloaded successfully."
