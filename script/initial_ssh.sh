#!/bin/bash

# 第二步，配置zsh和vim
cd
git clone https://github.com/chengpengzhao/My_vimrc.git
cd My_vimrc
git checkout dev-WSL
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
mkdir ~/.vim/UltiSnips
cp *.snippets ~/.vim/UltiSnips/
# cp ./'.vimrc(ssh)' ~/.vimrc
source ~/.zshrc
# 这一步完成后进入vim进行插件配置
# ==========================================================================
# 第三步，youcompleteme安装（安装贼jb复杂的插件代表）以及github配置
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all

git config --global user.name "chengpengzhao"
git config --global user.email "chengpeng_zhao@foxmail.com"
git config --global core.quotepath false  #防止用tab键自动补全的中文文件名乱码
git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.safecrlf true
ssh-keygen -t rsa -C "chengpeng_zhao@foxmail.com"

vim ~/.ssh/id_rsa.pub     #  复制添加到github


# ==========================================================================

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
