<<<<<<< HEAD
# php-fpm-apache-2.4
# Before running this ...

I recommend updating your ssh port and also changing the firewalld rules in prod.sh 
You can find it on line 75 of /install/prod.sh

## Vagrant
```bash
git clone https://github.com/bradallenfisher/drupal7-php-fpm-apache-2.4-centos7.git; cd drupal7-php-fpm-apache-2.4-centos7; vagrant up
```

## PROD
```bash
yes | yum -y install git && git clone https://github.com/bradallenfisher/drupal7-php-fpm-apache-2.4-centos7.git && cd drupal7-php-fpm-apache-2.4-centos7 && chmod 700 install/prod.sh && install/prod.sh
```
=======
# php7-centos7-mysql5.6

## One liner to install php 7 and mysql 5.6 in vagrant (local machine) --NOT WORKING YET>>> SOMETHING WITH CENTOS 7 AND APACHE

```bash
git clone https://github.com/bradallenfisher/php7-centos7-mysql5.6.git;cd php7-centos7-mysql5.6; vagrant up
```

- add below string to /etc/hosts file

192.168.19.07 local.phpng.dev

# Completely experimental... DON'T USE IN PRODUCTION
With that being said here's a one liner to get you started with this bleeding edge environment

```code
yum install git -y;git clone https://github.com/bradallenfisher/php7-centos7-mysql5.6.git; cd php7-centos7-mysql5.6; chmod 700 install.sh; ./install.sh
```

## How to use this
- log into a "FRESH" virtual machine from Linode or Digital Ocean
- run the one liner from above... 
- add a user other than root
- mv the post-install.sh script to that user's home directory
- run the post-install.sh script as the new user

dunzy!
>>>>>>> a54b4aa696a0e3e7c619e8ff034384dd31d654d4
