# php7-fpm-centos7-mysql5.7

## Vagrant
```bash
git clone https://github.com/bradallenfisher/php7-fpm-centos7-mysql5.7.git; cd php7-fpm-centos7-mysql5.7; vagrant up
```

## PROD
```bash
yes | yum -y install git && git clone https://github.com/bradallenfisher/php7-fpm-centos7-mysql5.7.git && cd php7-fpm-centos7-mysql5.7 && chmod 700 install/prod.sh && install/prod.sh
```
