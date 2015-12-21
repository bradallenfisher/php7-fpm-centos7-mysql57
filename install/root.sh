#/!/bin/bash

# install apache
yum install httpd -y

# get some repos
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm

# get latest mysql
yum install -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm 
yum install -y mysql mysql-server
systemctl enable mysqld.service
/bin/systemctl start  mysqld.service
yum update -y

yum install -y --enablerepo=remi-php70 php php-apcu php-fpm php-opcache php-cli php-common php-gd php-mbstring php-mcrypt php-pdo php-xml php-mysqlnd

# PHP
# The first pool
cat /vagrant/php/www.conf > /etc/php-fpm.d/www.conf

#opcache settings
cat /vagrant/php/opcache.ini > /etc/php.d/opcache.ini

#disable mod_php
cat /vagrant/php/php.conf > /etc/httpd/conf.d/php.conf

#disable some un-needed modules.
cat /vagrant/modules/00-base.conf > /etc/httpd/conf.modules.d/00-base.conf
cat /vagrant/modules/00-dav.conf > /etc/httpd/conf.modules.d/00-dav.conf
cat /vagrant/modules/00-lua.conf > /etc/httpd/conf.modules.d/00-lua.conf
cat /vagrant/modules/00-mpm.conf > /etc/httpd/conf.modules.d/00-mpm.conf
cat /vagrant/modules/00-proxy.conf > /etc/httpd/conf.modules.d/00-proxy.conf
cat /vagrant/modules/01-cgi.conf > /etc/httpd/conf.modules.d/01-cgi.conf

# BASIC PERFORMANCE SETTINGS
mkdir /etc/httpd/conf.performance.d/
cat /vagrant/performance/compression.conf > /etc/httpd/conf.performance.d/compression.conf
cat /vagrant/performance/content_transformation.conf > /etc/httpd/conf.performance.d/content_transformation.conf
cat /vagrant/performance/etags.conf > /etc/httpd/conf.performance.d/etags.conf
cat /vagrant/performance/expires_headers.conf > /etc/httpd/conf.performance.d/expires_headers.conf
cat /vagrant/performance/file_concatenation.conf > /etc/httpd/conf.performance.d/file_concatenation.conf
cat /vagrant/performance/filename-based_cache_busting.conf > /etc/httpd/conf.performance.d/filename-based_cache_busting.conf

# BASIC SECURITY SETTINGS
mkdir /etc/httpd/conf.security.d/
cat /vagrant/security/apache_default.conf > /etc/httpd/conf.security.d/apache_default.conf

# our domain config
mkdir /etc/httpd/conf.sites.d
echo IncludeOptional conf.sites.d/*.conf >> /etc/httpd/conf/httpd.conf
cat /vagrant/domains/80-domain.conf > /etc/httpd/conf.sites.d/test.conf

# our performance config
echo IncludeOptional conf.performance.d/*.conf >> /etc/httpd/conf/httpd.conf

# our security config
echo IncludeOptional conf.security.d/*.conf >> /etc/httpd/conf/httpd.conf

# fix date timezone errors
sed -i 's#;date.timezone =#date.timezone = "America/New_York"#g' /etc/php.ini

# Make sue services stay on after reboot
systemctl enable httpd.service
systemctl enable mysqld.service
systemctl enable php-fpm.service

sudo systemctl stop firewalld.service

# Start all the services we use.
systemctl start php-fpm.service
systemctl start  mysqld.service

#systemctl enable httpd
systemctl enable httpd
#systemctl start httpd
systemctl start httpd

echo "<?php phpinfo();?>" > /var/www/html/index.php
