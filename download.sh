#!/bin/bash
set -e  

URL="http://${NEXUS_IP}:8081/service/rest/v1/search/assets/download"
USER="${NEXUS_USER}"
PASS="${NEXUS_PASS}"

echo "Fetching latest artifacts from Nexus at ${NEXUS_IP}"

mkdir -p /root/app_deploy && cd /root/app_deploy

curl -u "$USER:$PASS" -L -s "${URL}?repository=spring-boot-repo&maven.extension=jar&sort=version&direction=desc"

curl -u "$USER:$PASS" -s "${URL}?repository=angular-app-repo&sort=version&direction=desc"

echo "Latest artifacts deployed successfully to $(hostname)"