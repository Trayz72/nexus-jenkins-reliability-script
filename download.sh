#!/bin/bash
set -e  

URL="http://${NEXUS_IP}:8081/service/rest/v1/search/assets"
USER="${NEXUS_USER}"
PASS="${NEXUS_PASS}"

echo "Fetching latest artifacts from Nexus at ${NEXUS_IP}..."

mkdir -p /root/app_deploy && cd /root/app_deploy

BACKEND_URL=$(curl -u "$USER:$PASS" -s -X GET "${URL}?repository=spring-boot-repo&maven.extension=jar&sort=version&direction=desc" \
| grep -Po '"downloadUrl" : "\K[^"]*' | head -1)

FRONTEND_URL=$(curl -u "$USER:$PASS" -s -X GET "${URL}?repository=angular-app-repo&sort=version&direction=desc" \
| grep -Po '"downloadUrl" : "\K[^"]*' | head -1)

echo "Downloading Backend: $BACKEND_URL"
curl -u "$USER:$PASS" -L "$BACKEND_URL" -o backend.jar

echo "Downloading Frontend: $FRONTEND_URL"
curl -u "$USER:$PASS" -L "$FRONTEND_URL" -o frontend.tar.gz

tar -xzf frontend.tar.gz && rm frontend.tar.gz

echo "Latest artifacts deployed successfully to $(hostname)"