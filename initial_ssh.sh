#!/bin/bash

sudo -i # 先运行这个进入root

cd /etc/apt/
if [  -f /etc/apt/sources.list ]; then
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
fi
#这个sources.list文件就是源文件，删除该文件，重新写一个
sudo rm /etc/apt/sources.list
sudo echo "deb-src http://archive.ubuntu.com/ubuntu xenial main restricted #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb http://mirrors.aliyun.com/ubuntu/ xenial multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse #Added by software-properties
deb http://archive.canonical.com/ubuntu xenial partner
deb-src http://archive.canonical.com/ubuntu xenial partner
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted multiverse universe #Added by software-properties
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-security multiverse" > sources.list

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git
sudo apt-get install curl -y
sudo apt-get install vim-gtk3
sudo apt-get install zsh
chsh -s $(which zsh) #设置zsh为默认终端
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo apt-get install autojump;git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions;git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  #安装autojump、zsh-autosuggestions、zsh-syntax-highlighting三个插件

cd
git clone https://github.com/chengpengzhao/My_vimrc.git 
cd My_vimrc
git checkout dev-WSL
mv ./.vimrc ~/.vimrc
mv ./.zshrc ~/.zshrc
sudo apt-get install ripgrep
# mv ./'.vimrc(ssh)' ../.vimrc
#sudo apt install build-essential cmake python3-dev
#cd ~/.vim/bundle/YouCompleteMe
#python3 install.py --all

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #安装oh-my-zsh
source ~/.zshrc
# sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
# sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
