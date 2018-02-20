# //TODO: Color output: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# //TODO: Color echo functions: https://gist.github.com/daytonn/8677243


# //TODO: automatic "Y" for tor packet installation

# //TODO: change hostname for avahi zeroconf

# //TODO: start tor after boot: https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=197052&p=1231906#p1231634

# Echo functions
RED='\033[0;31m'
PURPLE="\033[0;35m"
GREEN="\033[0;32m"
NC='\033[0m'
# Print purple
function echo_n {
    echo -e "${PURPLE}${1}${NC}"
}

function echo_green {
    echo -e "${GREEN}${1}${NC}"
}

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
echo root:$PASSWORD | chpasswd

# //TODO: does this crash yunohost? Is it needed?
# Update package list
echo_n "updating package list"
apt-get update

echo_n "upgrading packages"
apt-get upgrade

echo_n "Installing apt-transport-https"
apt-get install apt-transport-https

# Tor installation & hidden service creation
echo_n "Installing tor..."
sudo apt-get install tor

echo_n "Creating hidden service for ssh access..."
echo '# Hidden service for ssh' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_ssh/' >> /etc/tor/torrc
echo 'HiddenServicePort 22 127.0.0.1:22' >> /etc/tor/torrc

echo_n "Creating default hidden service for YunoHide..."
echo '# Default hidden service for YunoHide' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_default/' >> /etc/tor/torrc
echo 'HiddenServicePort 80 127.0.0.1:80' >> /etc/tor/torrc
echo 'HiddenServicePort 443 127.0.0.1:443' >> /etc/tor/torrc

echo_n "Restarting tor..."
service tor restart
echo_n "waiting for tor to generate hidden services(60s)"
sleep 60

hidden_service_ssh="$(cat /var/lib/tor/hidden_service_ssh/hostname)"
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"

echo_n "Starting YunoHost post-install..."
yunohost tools postinstall -d "$hidden_service_default" -p "$PASSWORD" --ignore-dyndns

# update firewall settings
echo_n "Updating firewall rules..."
echo_n "Updating firewall rules: IPv4+TCP"
#yunohost firewall disallow TCP 22 --ipv4-only --no-reload
yunohost firewall disallow TCP 25 --ipv4-only --no-reload
yunohost firewall disallow TCP 53 --ipv4-only --no-reload
yunohost firewall disallow TCP 80 --ipv4-only --no-reload
yunohost firewall disallow TCP 443 --ipv4-only --no-reload
yunohost firewall disallow TCP 465 --ipv4-only --no-reload
yunohost firewall disallow TCP 587 --ipv4-only --no-reload
yunohost firewall disallow TCP 993 --ipv4-only --no-reload
yunohost firewall disallow TCP 5222 --ipv4-only --no-reload
yunohost firewall disallow TCP 5269 --ipv4-only --no-reload

echo_n "Updating firewall rules: IPv6+TCP"
#yunohost firewall disallow TCP 22 --ipv6-only --no-reload
yunohost firewall disallow TCP 25 --ipv6-only --no-reload
yunohost firewall disallow TCP 53 --ipv6-only --no-reload
yunohost firewall disallow TCP 80 --ipv6-only --no-reload
yunohost firewall disallow TCP 443 --ipv6-only --no-reload
yunohost firewall disallow TCP 465 --ipv6-only --no-reload
yunohost firewall disallow TCP 587 --ipv6-only --no-reload
yunohost firewall disallow TCP 993 --ipv6-only --no-reload
yunohost firewall disallow TCP 5222 --ipv6-only --no-reload
yunohost firewall disallow TCP 5269 --ipv6-only --no-reload

echo_n "Updating firewall rules: pnpp+TCP"
#yunohost firewall disallow TCP 22 --pnpp-only --no-reload
yunohost firewall disallow TCP 25 --pnpp-only --no-reload
yunohost firewall disallow TCP 53 --pnpp-only --no-reload
yunohost firewall disallow TCP 80 --pnpp-only --no-reload
yunohost firewall disallow TCP 443 --pnpp-only --no-reload
yunohost firewall disallow TCP 465 --pnpp-only --no-reload
yunohost firewall disallow TCP 587 --pnpp-only --no-reload
yunohost firewall disallow TCP 993 --pnpp-only --no-reload
yunohost firewall disallow TCP 5222 --pnpp-only --no-reload
yunohost firewall disallow TCP 5269 --pnpp-only --no-reload

echo_n "Updating firewall rules: IPv4+UDP"
yunohost firewall disallow UDP 53 --ipv4-only --no-reload
yunohost firewall disallow UDP 5353 --ipv4-only --no-reload

echo_n "Updating firewall rules: IPv6+UDP"
yunohost firewall disallow UDP 53 --ipv6-only --no-reload
yunohost firewall disallow UDP 5353 --ipv6-only --no-reload

echo_n "Updating firewall rules: upnp+UDP"
yunohost firewall disallow UDP 53 --upnp-only --no-reload
yunohost firewall disallow UDP 5353 --upnp-only --no-reload

echo_n "Reloading firewall configuration"
yunohost firewall reload


# //TODO: echo_n "Adding YunoHide AppsList"

echo_g "\n\n\n###################################################"
echo_n "Finished YunoHide installation!\n"
echo_n "SSH-Address:"
echo_n "$hidden_service_ssh"
echo_n "YunoHost-Address:"
echo_n "$hidden_service_default"

# Start update after user has written down the infos
echo_n "Please copy and save the addresses shown above."
echo_n "You need them to access your server from the internet!"
read -rsp $'Press enter to continue...\n'
echo_g "###################################################"


# Second update/upgrade to upgrade yunohost
#echo "updating package list"
#apt-get update

#echo "upgrading packages"
# //TODO: let user update system using webpanel
#apt-get install apt-transport-https
#apt-get upgrade --fix-missing






