# Get password for admin account
echo "Enter the password you want to use for your yunohost admin account"
read -s -p "Password: " PASSWORD; echo
read -s -p "Confirm Password: " PASSCONFIRM; echo

if [[ "$PASSWORD" != "$PASSCONFIRM" ]]; then
 echo "Passwords do not match, exiting..."
 echo "Restart this script and try again!"
 exit -1
fi

# //TODO: change root password


# Update package list
echo "updating package list"
apt-get update


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
echo "waiting for tor to generate hidden services(60s)"
sleep 60

#echo "installing yunohost"
#chmod +x ./install_yunohost -a

hidden_service_ssh="$(cat /var/lib/tor/hidden_service_ssh/hostname)"
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"

echo "Starting YunoHost post-install..."
yunohost tools post_install -d "$hidden_service_default" -p "$PASSWORD" --ignore-dyndns

# //TODO: update firewall settings

echo "Adding YunoHide AppsList"
echo "SSH-Address:"
echo "$hidden_service_ssh"
echo "YunoHost-Address:"
echo "$hidden_service_default"
