#!/bin/bash
#additional packeges
#wget 
#yum install wget
#wget https://raw.githubusercontent.com/kideg20/new-server/master/auto.sh
#sudo chmod +x auto.sh
#sudo ./auto.sh
sudo yum update -y 
sudo rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm #zabbix 4.0
#sudo rpm -ivh https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm #zabbix 3.4
sudo yum install epel-release -y
sudo yum install -y net-tools nfs-utils bind-utils telnet htop mc vim-enhanced tcpdump traceroute links
sudo yum install -y zabbix-agent
#---------------------------need's root
#---------------edit .bachrc--------------------
wget -P /home/ https://raw.githubusercontent.com/kideg20/new-server/master/root.txt
#echo "cat /home/root.txt" >> ~/.bashrc
echo "alias l='ls -lahF --color=auto'" >> ~/.bashrc
echo "alias vi='vim'" >> ~/.bashrc
echo "PS1='\[\033[01;31m\]\u@\h:\[\033[02;34m\]\w\$\[\033[00m\] '" >> ~/.bashrc
echo "alias c='clear'" >> ~/.bashrc
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ..; cd ..'" >> ~/.bashrc
echo "alias ....='cd ..; cd ..; cd ..'" >> ~/.bashrc
echo "alias q='exit'" >> ~/.bashrc
echo "alias netport='netstat -nape --inet'" >> ~/.bashrc
echo "alias shutdownreboot='sudo shutdown -r now'" >> ~/.bashrc
echo "alias shutdownpoweroff='sudo shutdown -h now'" >> ~/.bashrc
echo "alias grep='grep --color=auto'" >> ~/.bashrc
echo "alias egrep='egrep --color=auto'" >> ~/.bashrc
echo "alias fgrep='fgrep --color=auto'" >> ~/.bashrc
source ~/.bashrc
#===================================================GRUB2 EDIT BOOT SCREEN======================================================
sed -i 's/ rhgb quiet//' /etc/grub2.cfg
#==============================
sudo systemctl enable zabbix-agent
sudo sed -i 's/Server=127.0.0.1/Server=10.135.0.130/g' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/ServerActive=127.0.0.1/ServerActive=10.135.0.130/g' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's/Hostname=Zabbix server/Hostname=VVD Test Tulpe Epak4/g' /etc/zabbix/zabbix_agentd.conf
sudo systemctl start zabbix-agent
#----------------------------
sudo firewall-cmd --permanent --new-service=zabbix
sudo firewall-cmd --permanent --service=zabbix --set-description="Allow zabbix server to connect to 10050/tcp"
sudo firewall-cmd --permanent --zone=public --add-port=10050/tcp
sudo firewall-cmd --permanent --service=zabbix --set-short=zabbix10050tcp
sudo firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
sudo firewall-cmd --permanent --add-service=zabbix
sudo firewall-cmd --reload
