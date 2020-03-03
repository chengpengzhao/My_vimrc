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

gpg -o ./keys/id_rsa --decrypt ./keys/ssh_id_rsa_encrypt

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
read -p "请指定自定义SSH端口号（可用范围为0-65535 推荐使用大端口号）：" Port;Port=${Port:-22233}
until  [[ $Port =~ ^([0-9]{1,4}|[1-5][0-9]{4}|6[0-5]{2}[0-3][0-5])$ ]];do
    read -p "请重新键入SSH自定义端口号：" Port;Port=${Port:-22233};
done
sed -i "/Port/c\Port $Port/" /etc/ssh/sshd_config
#******************************************************
echo "中文化Linux"
wget -N --no-check-certificate https://raw.githubusercontent.com/chengpengzhao/LocaleCN/master/LocaleCN.sh && bash LocaleCN.sh
wait
#******************************************************
sudo -u ${username} /bin/bash -c "sudo chmod -R 777 /home/${username}/.ssh" && \
sudo -u ${username} /bin/bash -c "eval "$(ssh-agent -s)" && ssh-add -k ~/.ssh/id_rsa "
wait
sudo -u ${username} /bin/bash -c "ssh -T git@github.com" && \
sudo chown -R ${username}:${username} /home/${username}/.ssh
sudo -u ${username} /bin/bash -c "sudo chmod 600 /home/${username}/.ssh/authorized_keys" && \
sudo -u ${username} /bin/bash -c "sudo chmod 777 /home/${username}/.ssh/id_rsa" && \
sudo -u ${username} /bin/bash -c "sudo chmod 600 /home/${username}/.ssh/id_rsa.pub" && \
sudo -u ${username} /bin/bash -c "sudo chmod 700 /home/${username}/.ssh"
echo 重启SSH服务...
sudo service sshd restart
passwd -d root    #清除root密码,无法用su切换到root
echo "脚本运行完成~"
su -l ${username}
