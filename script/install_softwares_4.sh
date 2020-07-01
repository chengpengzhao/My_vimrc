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
sudo apt install ctags -y && \ sudo add-apt-repository ppa:gnome-terminator && \
sudo apt-get update && \
#**************************************************************
#terminator配置
sudo apt-get install terminator
wait
cp -rf ../config/terminator ~/.config
wait
sudo add-apt-repository ppa:daniel-marynicz/filemanager-actions && \
sudo apt-get install filemanager-actions-nautilus-extension
#fma-config-tool 启动
# 1)新建action命名：Open in Terminator在Action标签页勾选"Display item in location context menu"
# 在Command标签页填写Path:/usr/bin/terminator，parameters:--working-directory=%d/%b
# 2)配置Preferences勾选"Create a root 'FileManager-Action' menu"
wait
#**************************************************************
#copyq
sudo add-apt-repository ppa:hluk/copyq && \
sudo apt update  && \
sudo apt install copyq
wait
#goldendict
sudo apt-get install goldendict
wait
cp ../config/.goldendict ~
wait
#proxychains
sudo apt-get install proxychains
wait
sudo cp ../config/proxychains.conf /etc/
#fcitx
sudo apt-get remove ibus && sudo add-apt-repository ppa:fcitx-team/nightly && sudo apt-get update && sudo apt-get install fcitx fcitx-config-gtk  fcitx-sogoupinyin && sudo apt-get install fcitx-table-all && im-switch -s fcitx -z default

git clone https://github.com/soimort/translate-shell && \
cd translate-shell/ && \
make && \
sudo make install
wait
sudo apt-get install unrar
wait
#gdb
sudo apt-get install gdb && sudo apt-get install cgdb
wait
cp ../config/cgdbrc ~/.cgdb/
wait
#v2ray
cp ../config/v2ray/Qv2ray.v2.5.0.linux-x64.AppImage ~/Desktop
chmod +x ~/Desktop/Qv2ray.v2.5.0.linux-x64.AppImage
wait
cp ../config/v2ray/v2ray-linux-64.zip ~ && \
unzip ~/v2ray-linux-64.zip
