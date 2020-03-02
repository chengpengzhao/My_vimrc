#!/usr/bin/env bash
cd ${0%/*} || exit 1    # Run from this directory
Green_font_prefix="[32m"
Red_font_prefix="[31m"
Green_background_prefix="[42;37m"
Red_background_prefix="[41;37m"
Font_color_suffix="[0m"
Info="[${Green_font_prefix}信息${Font_color_suffix}]"
Error="[${Red_font_prefix}错误${Font_color_suffix}]"
Tip="[${Green_font_prefix}注意${Font_color_suffix}]"
#**************************************************************
#apt-get update
wait
#apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y
wait
sudo apt-get upgrade -y && \
sudo apt-get install git -y && \
sudo apt-get install curl -y && \
sudo apt-get install vim-gtk3 -y && \
sudo apt-get install zsh -y && \
sudo apt-get install tree -y && \
sudo apt-get install wget -y && \
sudo apt install build-essential cmake python3-dev -y && \
sudo apt-get install python3-pip -y && \
sudo apt-get install nodejs -y
wait
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb &&\
dpkg -i ripgrep_11.0.2_amd64.deb
wait
yes yes|sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #安装oh-my-zsh
chsh -s $(which zsh) #设置zsh为默认终端
sudo apt-get install autojump -y;git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions;git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  #安装autojump、zsh-autosuggestions、zsh-syntax-highlighting三个插件
wait
echo
echo "${Green_font_prefix}第一阶段安装完成~${Font_color_suffix}"
echo "${Green_font_prefix}**************************************************************${Font_color_suffix}"
echo
echo "${Green_font_prefix}接下来配置Vim${Font_color_suffix}"

#**************************************************************
if [ -d ~/.vim ]
then
    rm -rf ~/.vim
fi
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd
if [ -d ~/My_vimrc ]
then
    rm -rf ~/My_vimrc
fi
git clone https://github.com/chengpengzhao/My_vimrc.git
cd My_vimrc
git checkout ubuntu
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
mkdir ~/.vim/UltiSnips
cp ./Snippets/*.snippets ~/.vim/UltiSnips/
cp engspchk-dict /usr/share/dict/
vim -c PlugInstall
wait
vim -c PlugUpdate
wait
sudo apt install clang-format -y
wait
clang-format -dump-config -style=Google > .clang-format
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all

#**************************************************************
echo
echo "${Green_font_prefix}Vim插件安装完成${Font_color_suffix}"
echo "${Green_font_prefix}**************************************************************${Font_color_suffix}"
echo "${Green_font_prefix}开始配置github${Font_color_suffix}"
git config --global user.name "chengpengzhao"
git config --global user.email "chengpeng_zhao@foxmail.com"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.safecrlf true
git config --global core.quotepath false  #防止用tab键自动补全的中文文件名被转义
git config --global core.pager cat    # 更改Git难受的分页器显示
git config --global core.editor vim   #修改ecommit的ditor为vim
git config --global alias.lg "log --color --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"             #让git log 更好看，配置自定义命令 git lg


echo "${Green_font_prefix}github配置完成${Font_color_suffix}"
zsh
source ~/.zshrc
