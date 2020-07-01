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
sudo apt-get update
wait
sudo apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y
wait
sudo apt-get upgrade -y
wait
sudo apt install ctags -y &&  sudo add-apt-repository ppa:gnome-terminator && \
sudo apt-get update
wait
#**************************************************************
#terminator配置
sudo apt-get install terminator -y
wait
mkdir -p ~/.config && cp -rf ../config/terminator ~/.config/
wait
sudo add-apt-repository ppa:daniel-marynicz/filemanager-actions && \
sudo apt-get install filemanager-actions-nautilus-extension -y
#fma-config-tool 启动
# 1)新建action命名：Open in Terminator在Action标签页勾选"Display item in location context menu"
# 在Command标签页填写Path:/usr/bin/terminator，parameters:--working-directory=%d/%b
# 2)配置Preferences勾选"Create a root 'FileManager-Action' menu"
wait
#**************************************************************
#copyq
sudo add-apt-repository ppa:hluk/copyq && \
sudo apt update  && \
sudo apt install copyq -y
wait
#goldendict
sudo apt-get install goldendict -y
wait
cp -rf ../config/.goldendict ~
wait
#proxychains
sudo apt-get install proxychains -y
wait
sudo cp -rf ../config/proxychains.conf /etc/
#fcitx
sudo apt-get remove ibus && sudo add-apt-repository ppa:fcitx-team/nightly && sudo apt-get update && sudo apt-get install fcitx fcitx-config-gtk  fcitx-sogoupinyin  -y && sudo apt-get install fcitx-table-all -y && im-switch -s fcitx -z default
wait
sudo apt-get install unrar -y
wait
#gdb
sudo apt-get install gdb  -y&& sudo apt-get install cgdb -y
wait
mkdir -p ~/.cgdb && cp -rf ../config/cgdbrc ~/.cgdb/
wait
#v2ray
cp -rf ../config/v2ray/Qv2ray.v2.5.0.linux-x64.AppImage ~/Desktop/
wait
chmod +x ~/Desktop/Qv2ray.v2.5.0.linux-x64.AppImage
wait
cp -rf ../config/v2ray/v2ray-linux-64.zip ~ && \
mkdir -p ~/v2ray-linux-64 && unzip ~/v2ray-linux-64.zip -d ~/v2ray-linux-64
wait
sudo apt-get install zsh -y
wait
sudo yes yes| sh ./install_ohmyzsh.sh
wait
chsh -s $(which zsh) #设置zsh为默认终端
wait
sudo apt-get install autojump -y
wait
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
wait
git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting  #安装autojump、zsh-autosuggestions、zsh-syntax-highlighting三个插件
wait
cp -f ../'.zshrc(ubuntu)' ~/.zshrc
wait
cd && git clone https://github.com/soimort/translate-shell && \
cd translate-shell/ && \
make && \
sudo make install
wait
zsh
wait
vim ~/.zshrc
