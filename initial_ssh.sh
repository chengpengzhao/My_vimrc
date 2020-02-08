#!/bin/bash

#用法： yes Yes | ./initial.sh
sudo apt-get update
# sudo apt-get upgrade
sudo apt-get install git
sudo apt-get install curl -y
sudo apt-get install vim-gtk3
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #安装oh-my-zsh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
git clone https://github.com/chengpengzhao/My_vimrc.git 
cd My_vimrc
git checkout dev-WSL
mv ./'.vimrc(ssh)' ../.vimrc

# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
# curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose
