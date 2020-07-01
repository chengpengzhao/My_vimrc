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
请不要在root帐号下运行该脚本！"

read -p "是否需要配置vim（y/n）：" chid
until [[ $chid =~ ^([y]|[n])$ ]]; do
    read -p "输入错误！请重新键入（y/n）：" chid
done
if [[ $chid == y ]]; then
    bash ./install_vim.sh
fi
wait
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb &&\
sudo dpkg -i ripgrep_11.0.2_amd64.deb
wait
sudo apt-get install zsh
wait
sudo yes yes| sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" #安装oh-my-zsh
wait
chsh -s $(which zsh) #设置zsh为默认终端
wait
echo "${Green_font_prefix}第一阶段安装完成~${Font_color_suffix}"
echo "${Green_font_prefix}**************************************************************${Font_color_suffix}"

#**************************************************************
echo "${Green_font_prefix}**************************************************************${Font_color_suffix}"
echo "${Green_font_prefix}开始配置github${Font_color_suffix}"
git config --global user.name "chengpengzhao"
git config --global user.email "cavsarpwgnckamekerokardank89@gmail.com"
git config --global user.signingkey A11C5129AAE5BA77
git config --global commit.gpgsign true
git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.safecrlf true
git config --global core.quotepath false  #防止用tab键自动补全的中文文件名被转义
git config --global core.pager cat    # 更改Git难受的分页器显示
git config --global core.editor vim   #修改ecommit的ditor为vim
git config --global alias.lg "log --color --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"             #让git log 更好看，配置自定义命令 git lg


echo "${Green_font_prefix}github配置完成${Font_color_suffix}"
cd
sudo apt-get install autojump -y
wait
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH/custom/plugins/zsh-autosuggestions
wait
git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting  #安装autojump、zsh-autosuggestions、zsh-syntax-highlighting三个插件
wait
cp ../'.zshrc(ubuntu)' ~/.zshrc
wait
zsh
wait
vim ~/.zshrc
