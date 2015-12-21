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

#todo
rm /etc/httpd/conf.d/php.conf -rf
rm /etc/httpd/conf.modules.d/10-php.conf -rf

# load php into apache
touch /etc/httpd/conf.d/php7.conf
cat << EOF > /etc/httpd/conf.d/php7.conf
LoadModule php7_module        /usr/lib64/httpd/modules/libphp7.so
<FilesMatch \.php$>
SetHandler application/x-httpd-php
</FilesMatch>
EOF

#make sure you can index with php and use clean urls in drupal
touch /etc/httpd/conf.d/html.conf
cat << EOF > /etc/httpd/conf.d/html.conf
<Directory "/var/www/html">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>
EOF

# get varnish duh!
#yum install varnish -y
#sed -i 's/VARNISH_LISTEN_PORT=6081/VARNISH_LISTEN_PORT=80/g' /etc/varnish/varnish.params
#sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf

#systemctl enable varnish
systemctl enable httpd
#systemctl start varnish
systemctl start httpd

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
composer global require drush/drush:7.*
