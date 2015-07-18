!#/bin/bash

rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum localinstall mysql-community-release-el7-5.noarch.rpm
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
