#!/bin/bash

VERSION=$1

NEXUS_URL="http://${NEXUS_IP}:8081/repository"
USER="${NEXUS_USER}"
PASS="${NEXUS_PASS}"

echo "Deploying version: $VERSION to $(hostname) using Nexus at ${NEXUS_IP}"

mkdir -p ~/app_deploy && cd ~/app_deploy

curl -u "$USER:$PASS" -L "${NEXUS_URL}/spring-boot-repo/com/myapp/backend/${VERSION}/backend-${VERSION}.jar" -o backend.jar


curl -u "$USER:$PASS" -L "${NEXUS_URL}/angular-app-repo/frontend-${VERSION}.tar.gz" -o frontend.tar.gz

tar -xzf frontend.tar.gz && rm frontend.tar.gz

echo "Artifacts downloaded and extracted successfully."