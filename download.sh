#!/bin/bash

VERSION=$1
# REMOVE the hardcoded NEXUS_IP line
# The NEXUS_IP variable will now come from the 'export' in Jenkinsfile2

NEXUS_URL="http://${NEXUS_IP}:8081/repository"
USER="${NEXUS_USER}"
PASS="${NEXUS_PASS}"

echo "Deploying version: $VERSION to $(hostname) using Nexus at ${NEXUS_IP}"

# Create deploy directory
mkdir -p ~/app_deploy && cd ~/app_deploy

# Download Backend JAR
curl -u "$USER:$PASS" -L "${NEXUS_URL}/spring-boot-repo/com/myapp/backend/${VERSION}/backend-${VERSION}.jar" -o backend.jar

# Download Frontend Tarball
curl -u "$USER:$PASS" -L "${NEXUS_URL}/angular-app-repo/frontend-${VERSION}.tar.gz" -o frontend.tar.gz

# Extract and Clean up
tar -xzf frontend.tar.gz && rm frontend.tar.gz

echo "Artifacts downloaded and extracted successfully."