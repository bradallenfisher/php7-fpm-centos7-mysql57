# php7-fpm-centos7-mysql5.6

## Vagrant
```bash
git clone https://github.com/bradallenfisher/php7-fpm-centos7-mysql5.6.git; cd php7-fpm-centos7-mysql5.6; vagrant up
```

## PROD
```bash
yes | yum -y install git && git clone https://github.com/bradallenfisher/php7-fpm-centos7-mysql5.6.git && cd php7-fpm-centos7-mysql5.6 && chmod 700 install/prod.sh && install/prod.sh
```
