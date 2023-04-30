#!/bin/bash
#Part 7: Yum Repo
#1- Install tmux on your machine
#2- Install apache server on your machine(httpd) and Install mysql.
#3- Create a local yum repository on your local machine(available publicly) with the zabbix rpms:
#https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/
#4- Disable all other repositories and keep only the new repo
#5- Install zabbix rpms from the new repo (Download zabbix, zabbix-web,php, zabbix-server,zabbix-agent rpm’s and their dependencies)

sudo rm -rf zabbix
sudo rm -rf /var/www/html/localrepo

sudo yum install epel-release -y
sudo yum install nginx -y
sudo yum install tmux -y
sudo yum install httpd -y
sudo yum install mysql-server -y

sudo yum group install "Development Tools"

sudo systemctl start httpd
sudo systemctl enable httpd
#sudo systemctl start mysql
#sudo systemctl enable mysql

mkdir zabbix
cd zabbix/
mkdir rpms
cd rpms/

wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-agent-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-agent2-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-get-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-web-4.4.9-1.el7.noarch.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-java-gateway-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-js-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-nginx-conf-4.4.9-1.el7.noarch.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-server-mysql-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-proxy-pgsql-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-proxy-sqlite3-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-release-4.4-1.el7.noarch.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-sender-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-server-pgsql-4.4.9-1.el7.x86_64.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-web-mysql-4.4.9-1.el7.noarch.rpm
wget https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-web-pgsql-4.4.9-1.el7.noarch.rpm
wget http://fping.org/dist/fping-3.10.tar.gz
tar -xvf fping-3.10.tar.gz
cd fping-3.10
./configure
make
make install

sudo yum install createrepo
sudo mkdir /var/www/html/localrepo
sudo mv /root/LinuxSystemAdministration/LinuxSystemAdministration/zabbix/rpms/*.rpm /var/www/html/localrepo

sudo createrepo /var/www/html/localrepo

sudo echo "[localrepo]" >> /etc/yum.repos.d/localrepo.repo
sudo echo "name=Local Repository" >> /etc/yum.repos.d/localrepo.repo
sudo echo "baseurl=file:///var/www/html/localrepo/" >> /etc/yum.repos.d/localrepo.repo
sudo echo "gpgcheck=0" >> /etc/yum.repos.d/localrepo.repo
sudo echo "enabled=1" >> /etc/yum.repos.d/localrepo.repo

sudo yum clean all
#sudo yum update

sudo yum-config-manager --enable localrepo

#sudo yum install --resolve zabbix-agent2.x86_64 zabbix-web.noarch zabbix-server-mysql.x86_64 zabbix-get.x86_64

sudo yum install zabbix-agent zabbix-agent2 zabbix-get zabbix-web zabbix-java-gateway zabbix-js zabbix-nginx-conf zabbix-server-mysql zabbix-proxy-pgsql zabbix-proxy-sqlite3 zabbix-release zabbix-sender zabbix-server-pgsql zabbix-web-mysql zabbix-web-pgsql

#sudo yum install localrepo \*






