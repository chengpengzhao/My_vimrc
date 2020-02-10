#!/bin/bash

#用法： yes Yes | ./initial.sh
# 最开始把软件源先配置好
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y
sudo apt-get install curl -y
sudo apt-get install vim-gtk3 -y
sudo apt-get install zsh -y
sudo apt-get install tree -y
sudo apt install build-essential cmake python3-dev -y
sudo apt-get install python3-pip -y
sudo apt-get install nodejs -y
# sudo apt-get install nodejs-legacy -y
sudo apt-get install npm -y
sudo npm install -g hexo-cli

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #安装oh-my-zsh
#安装后会提示进入zsh，后面的命令会被忽略
echo "============================ \n"
echo "打开initial.sh查看后续步骤！"
exit
# ==========================================================================
# 第二步，配置zsh和vim
cd
sudo apt-get install autojump;git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions;git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  #安装autojump、zsh-autosuggestions、zsh-syntax-highlighting三个插件

chsh -s $(which zsh) #设置zsh为默认终端
git clone https://github.com/chengpengzhao/My_vimrc.git
cd My_vimrc
git checkout dev-WSL
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
mkdir ~/.vim/UltiSnips
cp *.snippets ~/.vim/UltiSnips/
# cp ./'.vimrc(ssh)' ../.vimrc
source ~/.zshrc
# 这一步完成后进入vim进行插件配置
# ==========================================================================
# 第三步，youcompleteme安装（安装贼jb复杂的插件代表）以及github配置
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all

git config --global user.name "chengpengzhao"
git config --global user.email "chengpengzhao@foxmail.com"
git config --global core.quotepath false  #防止用tab键自动补全的中文文件名乱码
git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.safecrlf true
ssh-keygen -t rsa -C "chengpengzhao@foxmail.com"

vim ~/.ssh/id_rsa.pub     #  复制添加到github


# sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
# sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
