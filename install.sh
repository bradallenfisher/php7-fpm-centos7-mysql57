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
echo [zend-php7] >> /etc/yum.repos.d/php7-nightly.repo
echo name = PHP7 nightly by Zend Technologies >> /etc/yum.repos.d/php7-nightly.repo
echo baseurl = http://repos.zend.com/zend-server/early-access/php7/repos/centos/ >> /etc/yum.repos.d/php7-nightly.repo
echo gpgcheck=0 >> /etc/yum.repos.d/php7-nightly.repo
yum install php7-nightly -y
systemctl restart httpd
cp /usr/local/php7/libphp7.so /etc/httpd/modules/

#make sure you can index with php
sed -i 's/DirectoryIndex index/DirectoryIndex index.php index/g' httpd.conf

#get some dependancies... not sure bout all this yet, but it seems to work
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


