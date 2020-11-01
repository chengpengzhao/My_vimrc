#!/usr/bin/env bash
cd ~ && mkdir bitwarden && cd bitwarden
cat >> docker-compose.yml << EOF
version: "3"

services:
  bitwarden:
    image: bitwardenrs/server
    restart: always
    ports:
    - "8080:80"
    - "8081:3012"
    volumes:
      - ./bw-data:/data
    environment:
      WEBSOCKET_ENABLED: "true"
      SIGNUPS_ALLOWED: "true"
      WEB_VAULT_ENABLED: "true"
EOF
docker-compose up -d
wait
#docker-compose down && docker-compose up -d
