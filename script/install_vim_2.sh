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
echo -e "${Tip} \
开始安装vim配置~"

sudo apt-get update
wait
sudo apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y
wait
sudo apt-get upgrade -y
wait
#安装一些基础软件
sudo apt-get install git -y && \
sudo apt-get install curl -y && \
sudo apt-get install vim-gtk3 -y && \
sudo apt-get install tree -y && \
sudo apt-get install wget -y && \
sudo apt install build-essential cmake python3-dev -y && \
sudo apt install gnupg -y && \
sudo apt-get install python3-pip -y && \
sudo apt install clang-format -y && \
sudo apt install ctags -y && \
#-----------------------------------------------------------------
read -p "是否需选择简化版Vim插件（y/n）：" chid
until [[ $chid =~ ^([y]|[n])$ ]]; do
    read -p "输入错误！请重新键入（y/n）：" chid
done
if [[ $chid == y ]]; then
    sudo cp ../'.vimrc(ssh)' ~/.vimrc
else
sudo cp ../.vimrc  ~/.vimrc

fi
sudo cp -rf ../config/.vim  ~
sudo cp ../Snippets/*.snippets ~/.vim/UltiSnips/
sudo cp ../config/engspchk-dict /usr/share/dict/
wait
vim -c PlugInstall
if [[ $chid == n ]]; then
    clang-format -dump-config -style=Google > .clang-format
    cd ~/.vim/plugged/YouCompleteMe
    python3 install.py --all
fi
