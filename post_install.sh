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
drush site-install --db-url=mysql://root@localhost:22/test -y
sudo chmod -R 755 /var/www/html/sites/default/files/
sudo chown -R apache:apache /var/www/html/sites/default/files/

drush cleanup -y
drush cook d7adminux -y
exec bash

echo "DUNZY!"
