username=$(whoami);
sudo chmod -R 700 /home/${username}/.ssh
wait
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa
wait
sudo chown -R ${username}:${username} /home/${username}/.ssh && \
sudo chmod 600 /home/${username}/.ssh/authorized_keys && \
sudo chmod 600 /home/${username}/.ssh/id_rsa.pub && \
sudo chmod 700 /home/${username}/.ssh
wait
echo 重启SSH服务...
sudo service sshd restart
wait
passwd -d root    #清除root密码,无法用su切换到root
wait
