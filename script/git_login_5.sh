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

gpg -o ./keys/id_rsa --decrypt ./keys/ssh_id_rsa_encrypt
wait
mv ./keys/id_rsa ~/.ssh/
sudo chmod 600 ~/.ssh/id_rsa && \
sudo chmod 700 ~/.ssh
wait
ssh -T git@github.com
