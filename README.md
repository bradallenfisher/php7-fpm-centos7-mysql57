# php7-centos7-mysql5.6

## One liner to install php 7 and mysql 5.6 in vagrant (local machine)

```bash
git clone https://github.com/bradallenfisher/php7-centos7-mysql5.6.git;cd php7-centos7-mysql5.6; vagrant up
```

- add below string to /etc/hosts file

192.168.7.7 local.php7.dev

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
