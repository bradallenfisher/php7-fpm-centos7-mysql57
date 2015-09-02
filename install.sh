#/!/bin/bash

#install git
yum install git -y

# install apache
yum install httpd -y

# get some repos
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# get latest mysql
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum localinstall mysql-community-release-el7-5.noarch.rpm -y
yum update -y
yum install mysql-community-server -y
systemctl enable mysqld.service
/bin/systemctl start  mysqld.service

# install some dev tools
yum groupinstall 'Development tools' -y

yum install --enablerepo=webtatic-testing php70w php70w-opcache php70w-cli php70w-common php70w-gd php70w-mbstring php70w-mcrypt php70w-pdo php70w-xml php70w-mysqlnd

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
yum install varnish -y
sed -i 's/VARNISH_LISTEN_PORT=6081/VARNISH_LISTEN_PORT=80/g' /etc/varnish/varnish.params
sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf

systemctl enable varnish
systemctl enable httpd
systemctl start varnish
systemctl start httpd



#get drush
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "ON TO STEP 2...."
