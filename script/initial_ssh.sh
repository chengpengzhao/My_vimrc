#!/bin/bash


sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
systemctl start docker
systemctl enable docker
cd ~ && mkdir bitwarden && cd bitwarden

cat >> docker-compose.yml << EOF
version: '3'

services:
  bitwarden:
    image: bitwardenrs/server:latest
    container_name: bitwarden
    restart: always
    volumes:
      - ./data:/data
    env_file:
      - config.env
    ports:
      - "8081:80"
EOF

cat >> config.env << EOF
DOMAIN=https://bw.example.com
DATABASE_URL=/data/bitwarden.db
ROCKET_WORKERS=10
WEB_VAULT_ENABLED=true
SIGNUPS_ALLOWED=true
EOF
docker-compose up -d
docker-compose down && docker-compose up -d
