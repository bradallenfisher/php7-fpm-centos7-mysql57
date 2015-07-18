!#/bin/bash
#install git
yum install git -y

# install nano
yum install nano

# install apache
yum install httpd -y

# get some repos
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum localinstall mysql-community-release-el7-5.noarch.rpm -y

# get latest mysql
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum localinstall mysql-community-release-el7-5.noarch.rpm -y
yum update -y
yum install mysql-community-server -y

# install some dev tools
yum groupinstall 'Development tools' -y

#add the PHP7 Repo
touch /etc/yum.repos.d/php7-nightly.repo
cat << EOF >/etc/yum.repos.d/php7-nightly.repo
[zend-php7]
name = PHP7 nightly by Zend Technologies
baseurl = http://repos.zend.com/zend-server/early-access/php7/repos/centos/
gpgcheck=0
EOF

# install php 7
yum install php7-nightly -y
cp /usr/local/php7/libphp7.so /etc/httpd/modules/

# load php into apache
touch /etc/httpd/conf.d/php7.conf
cat << EOF > /etc/httpd/conf.d/php7.conf
LoadModule php7_module        /usr/lib64/httpd/modules/libphp7.so
<FilesMatch \.php$> 
SetHandler application/x-httpd-php
</FilesMatch> 
EOF

#copy the php.ini file into the loadable location
cp /etc/php.ini /usr/local/php7/etc/php.ini

#create location for loadable ini files.
mkdir /usr/local/php7/etc/conf.d

#start by adding in opcache ini
cp opcache.ini /usr/local/php7/etc/conf.d/

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

#get some dependancies... not sure bout all this yet, but it seems to allow drush to work
yum install php-pdo php-gd php-dom php-pecl-apcu php-mcrypt php-mbstring php-pdo_mysql php-cli -y

#restart and keep on
/bin/systemctl restart  httpd.service
/bin/systemctl restart  mysqld.service
systemctl enable mysqld.service
systemctl enable httpd.service

#get drush
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require drush/drush:7.*

echo "export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc

# install drush recipes
drush dl drush_recipes -y
drush dl drupal --destination=/var/www/ --drupal-project-rename=html -y

cd /var/www/html
drush site-install --db-url=mysql://root@localhost:22/test -y
chmod -R 755 /var/www/html/sites/default/files/
chown -R apache:apache /var/www/html/sites/default/files/
exec bash

echo "DUNZY!"
