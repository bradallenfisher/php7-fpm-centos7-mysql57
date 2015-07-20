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
