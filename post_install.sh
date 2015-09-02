#!/bin/bash
# run as drush user.

cd $HOME
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
php /usr/local/bin/composer global require drush/drush:6.*
# symlink into drush
sudo ln -sf $HOME/.composer/vendor/drush/drush /usr/bin/drush
# add to local path
echo 'export PATH="$PATH:/usr/bin/drush"' >> $HOME/.bashrc
# reload bashrc so drush calls can function
source .bashrc

# install drush recipes
drush dl drush_recipes -y
drush dl drupal --destination=/var/www/ --drupal-project-rename=html -y

cd /var/www/html
drush site-install --db-url=mysql://root@localhost:22/test -y
chmod -R 755 /var/www/html/sites/default/files/
chown -R apache:apache /var/www/html/sites/default/files/
exec bash

echo "DUNZY!"
