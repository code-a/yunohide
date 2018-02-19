# Get password for admin account
echo "Enter the password you want to use for your admin account"
read -s -p "Password: " PASSWORD; echo
read -s -p "Confirm Password: " PASSCONFIRM; echo

if [[ "$PASSWORD" != "$PASSCONFIRM" ]]; then
 echo "Passwords do not match, exiting..."
 echo "Restart this script and try again!"
 exit -1
fi

# Tor installation & hidden service creation
echo "Installing tor..."
sudo apt-get install tor

echo "Creating hidden service for ssh access..."
echo '# Hidden service for ssh' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_ssh/' >> /etc/tor/torrc
echo 'HiddenServicePort 22 127.0.0.1:22' >> /etc/tor/torrc

echo "Creating default hidden service for YunoHide..."
echo '# Default hidden service for YunoHide' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_default/' >> /etc/tor/torrc
echo 'HiddenServicePort 80 127.0.0.1:80' >> /etc/tor/torrc
echo 'HiddenServicePort 443 127.0.0.1:443' >> /etc/tor/torrc

echo "Restarting tor..."
service tor restart
# TODO: get password from user
hidden_service_ssh="$(cat /var/lib/tor/hidden_service_ssh/hostname)"
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"

echo "Starting YunoHost installation..."
yunohost tools post_install -d "$hidden_service_default" -p "$PASSWORD" --ignore-dyndns

echo "Adding YunoHide AppsList"
