#!/usr/bin/env bash
sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
wait
sudo cp ../config/docker-compose-Linux-x86_64   /usr/local/bin/docker-compose
wait
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl start docker
sudo systemctl enable docker
