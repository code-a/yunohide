# //TODO: Color output: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# //TODO: Color echo functions: https://gist.github.com/daytonn/8677243

# //TODO: Close Ports TCP ipv4+ipv6+upnp: 22, 25, 53, 80, 443, 465, 587, 993, 5222, 5269
# //TODO: Close Ports UDP ipv4+ipv6+upnp: 53, 5353
# //TODO Example TCP ipv4: yunohost firewall disallow TCP 22 --ipv4-only --no-reload
# //TODO Example TCP ipv6: yunohost firewall disallow TCP 22 --ipv6-only --no-reload
# //TODO Example TCP upnp: yunohost firewall disallow TCP 22 --upnp-only --no-reload
# //TODO: reload firewall after modification:  yunohost firewall reload

# //TODO: change root pw: echo root:$2 | chpasswd

# //TODO: automatic "Y" for tor packet installation

# Get password for admin account
echo "Enter the password you want to use for your yunohost admin account and the root user"
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

hidden_service_ssh="$(cat /var/lib/tor/hidden_service_ssh/hostname)"
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"

echo "Starting YunoHost post-install..."
yunohost tools postinstall -d "$hidden_service_default" -p "$PASSWORD" --ignore-dyndns

# //TODO: update firewall settings

echo "Adding YunoHide AppsList"
echo "SSH-Address:"
echo "$hidden_service_ssh"
echo "YunoHost-Address:"
echo "$hidden_service_default"
