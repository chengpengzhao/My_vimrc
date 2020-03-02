#!/bin/bash

apt-get update
apt-get install sudo -y
sudo apt-get upgrade -y
sudo apt-get install git -y
sudo apt-get install curl -y
sudo apt-get install vim-gtk3 -y
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/chengpengzhao/My_vimrc.git
cd My_vimrc
git checkout dev-WSL
cp .vimrc ~/.vimrc
cp ./'.vimrc(ssh)' ~/.vimrc
cd
useradd -m -s /bin/bash zzzcp   #创建新用户
passwd zzzcp
usermod -aG sudo zzzcp     #获取root权限   sudo -i 来切换
su -l zzzcp     #切换用户
ssh-keygen -t rsa  #VPS上生成，故拷走私钥
cd .ssh/
cat id_rsa.pub >> authorized_keys # 将公钥写入到 authorized_keys 文件
sudo chmod 600 authorized_keys
sudo chmod 700 ~/.ssh
#sudo vim /etc/ssh/sshd_config
