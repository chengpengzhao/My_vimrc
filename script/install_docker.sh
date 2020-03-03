#!/usr/bin/env bash

sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
wait
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
wait
sudo chmod +x /usr/local/bin/docker-compose
systemctl start docker
systemctl enable docker
