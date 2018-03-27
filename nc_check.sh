# source: https://docs.nextcloud.com/server/12/admin_manual/configuration_files/encryption_configuration.html
sudo -u nextcloud php /var/www/nextcloud/console.php maintenance:mode --on
sudo -u nextcloud php /var/www/nextcloud/console.php encryption:enable
sudo -u nextcloud php /var/www/nextcloud/console.php encryption:encrypt-all
sudo -u nextcloud php /var/www/nextcloud/console.php maintenance:mode --off
