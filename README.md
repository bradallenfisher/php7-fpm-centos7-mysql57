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
