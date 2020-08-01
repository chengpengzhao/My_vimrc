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
read -p "请输入待创建的用户名:" username
if id -u $username >/dev/null 2>&1; then

    echo "user exists, delete it first"
    userdel ${username}
else :
fi
useradd -m -s /bin/bash ${username} #创建新用户
passwd ${username}
wait
apt install sudo -y  #没有sudo时先安装
wait
usermod -aG sudo ${username} #获取root权限   sudo -i 来切换

#******************************************************

if [ -d /home/${username}/.ssh ];then
    :
else
    mkdir /home/${username}/.ssh
fi
cp ./keys/ssh_id_rsa.pub /home/${username}/.ssh/authorized_keys

#gpg -o ./keys/id_rsa --decrypt ./keys/ssh_id_rsa_encrypt

wait
mv ./keys/id_rsa /home/${username}/.ssh/
cp /home/${username}/.ssh/authorized_keys /home/${username}/.ssh/id_rsa.pub
[ $? == 0 ] && echo "SSH Key installed successfully!"

#******************************************************
echo "Disabled password login in SSH."
sed -i '/PasswordAuthentication /c\PasswordAuthentication no' /etc/ssh/sshd_config
echo "Disabled root login in SSH."
sed -i '/PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
echo "Disabled empty password."
sed -i '/PermitEmptyPasswords/c\PermitEmptyPasswords no' /etc/ssh/sshd_config
echo "Enable SSh Authentication"
sed -i '/PubkeyAuthentication/c\PubkeyAuthentication yes' /etc/ssh/sshd_config
if grep "RSAAuthentication" /etc/ssh/sshd_config >/dev/null  2>&1  ;then
    sed -i '/RSAAuthentication/c\RSAAuthentication yes' /etc/ssh/sshd_config
else
    echo "RSAAuthentication yes #RSA认证" >> /etc/ssh/sshd_config
fi
if  grep "UseDNS" /etc/ssh/sshd_config >/dev/null  2>&1  ;then
    sed -i '/UseDNS/c\UseDNS no' /etc/ssh/sshd_config
else
    echo "UseDNS no     #加快ssh连接速度" >> /etc/ssh/sshd_config
fi
echo "Change Port number"
# 替换Port .*为Port $Port
read -p "请指定自定义SSH端口号（可用范围为0-65535 推荐使用大端口号，默认为26700）：" Port;Port=${Port:-26700}
until  [[ $Port =~ ^([0-9]{1,4}|[1-5][0-9]{4}|6[0-5]{2}[0-3][0-5])$ ]];do
    read -p "请重新键入SSH自定义端口号：" Port;Port=${Port:-26700};
done
sed -i "/Port/c\Port ${Port}" /etc/ssh/sshd_config
#******************************************************
echo "中文化Linux"
bash ./LocaleCN.sh
wait
#******************************************************
mv ../../My_vimrc   /home/${username}/
sudo chmod -R 777 /home/${username}/My_vimrc
wait
echo "脚本运行完成~接下来记得运行下一个脚本修改ssh文件权限"
su -l ${username}
