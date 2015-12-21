#/!/bin/bash

# install apache
yum install httpd -y

# get some repos
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm

# get latest mysql
yum install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum install mysql mysql-server -y
systemctl enable mysqld.service
/bin/systemctl start  mysqld.service

# install some dev tools
yum groupinstall 'Development tools' -y

yum install -y --enablerepo=remi-php70 php php-fpm php-opcache php-cli php-common php-gd php-mbstring php-mcrypt php-pdo php-xml php-mysqlnd

#systemctl enable varnish
systemctl enable httpd
#systemctl start varnish
systemctl start httpd
