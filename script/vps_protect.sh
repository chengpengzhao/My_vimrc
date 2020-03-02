#!/bin/bash
# ===================================================
useradd -m -s /bin/bash zzzcp   #创建新用户
passwd zzzcp
apt install sudo -y  #没有sudo时先安装
usermod -aG sudo zzzcp     #获取root权限   sudo -i 来切换
su -l zzzcp     #切换用户
ssh-keygen -t rsa  #VPS上生成，故拷走私钥
cd .ssh/
cat id_rsa.pub >> authorized_keys # 将公钥写入到 authorized_keys 文件
sudo chmod 600 authorized_keys
sudo chmod 700 ~/.ssh
sudo vim /etc/ssh/sshd_config
# PasswordAuthentication no  禁止密码登录（先测试密钥能正常登录再关，不然只能哭）
# PermitRootLogin no    禁root登录
# PermitEmptyPasswords no #禁止空密码
# RSAAuthentication yes #RSA认证
# PubkeyAuthentication yes #开启公钥验证
# UseDNS no        #加快ssh连接速度
# Port  xxxxx             修改默认端口
# 指定密钥路径前的注释去掉
sudo service sshd restart
sudo passwd -d root    #清除root密码,无法用su切换到root
# ===================================================
