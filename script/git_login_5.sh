#!/usr/bin/env bash
cd ${0%/*} || exit 1    # Run from this directory
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
Info="[${Green_font_prefix}信息${Font_color_suffix}]"
Error="[${Red_font_prefix}错误${Font_color_suffix}]"
Tip="[${Green_font_prefix}注意${Font_color_suffix}]"
[[ $EUID != 0 ]] && echo -e "${Error} \
当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 \
${Green_background_prefix}sudo su${Font_color_suffix} \
命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。\
" && exit 1
#******************************************************
read -p "使用前请确保已经导入了GPG密钥，否则无法解密ssh的私钥文件（y/n）：" chid
until [[ $chid =~ ^([y]|[n])$ ]]; do
    read -p "使用前请确保已经导入了GPG密钥，否则无法解密ssh的私钥文件（y/n）："  chid
done
if [[ $chid == y ]]; then
    :
else [[ $chid == n ]]
    exit 1;
fi

mkdir -p ~/.ssh
cp ./keys/ssh_id_rsa.pub ~/.ssh/authorized_keys
gpg -o ./keys/id_rsa --decrypt ./keys/ssh_id_rsa_encrypt
wait
mv ./keys/id_rsa ~/.ssh/
sudo chmod 600 ~/.ssh/authorized_keys && \
sudo chmod 700 ~/.ssh

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
wait
ssh -T git@github.com
