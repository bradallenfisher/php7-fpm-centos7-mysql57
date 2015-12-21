#!/bin/bash

composer global require drush/drush:7.*
echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> $HOME/.bashrc
source $HOME/.bashrc

# install drush recipes
drush dl drush_recipes -y
drush dl drush_cleanup
drush cc drush

sudo chown -R vagrant:vagrant /var/www/
drush dl drupal --destination=/var/www/ --drupal-project-rename=html -y

cd /var/www/html
drush site-install --account-pass=admin --db-url=mysql://root@localhost:22/test -y
sudo chmod -R 755 /var/www/html/sites/default/files/
sudo chown -R apache:apache /var/www/html/sites/default/files/

#start the apache service now that we have an .htaccess file
sudo systemctl start httpd.service

drush cleanup -y
drush cook d7adminux -y
drush cook d7adminux -y

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm gemset use global && gem install bundler

sudo service firewalld stop

exec bash
echo "DUNZY!"
