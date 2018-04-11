# //TODO: change hostname for avahi zeroconf

# //TODO: start tor after boot: https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=197052&p=1231906#p1231634

############################## HELPER FUNCTIONS ####################################
# source: https://misc.flogisoft.com/bash/tip_colors_and_formatting
# source2: https://gist.github.com/daytonn/8677243
RED='\033[0;31m'
PURPLE="\033[0;35m"
GREEN="\033[0;32m"
NC='\033[0m'
# Print purple
function echo_n {
    echo -e "${PURPLE}${1}${NC}"
}

function echo_g {
    echo -e "${GREEN}${1}${NC}"
}

############################## PASSWORD SETUP ####################################
# Get password for admin account
echo_n "Enter the password you want to use for your yunohost admin account and the root user"
read -s -p "Password: " PASSWORD; echo
read -s -p "Confirm Password: " PASSCONFIRM; echo

if [[ "$PASSWORD" != "$PASSCONFIRM" ]]; then
 echo "Passwords do not match, exiting..."
 echo "Restart this script and try again!"
 exit -1
fi

# //change root password
echo root:$PASSWORD | chpasswd


############################## SYSTEM UPDATE ####################################
# Update package list
echo_n "updating package list"
apt-get -y update

# //TODO: upgrade
#echo_n "upgrading packages"
#apt-get -y upgrade
#echo_n "dist-upgrade"
#apt-get -y dist-upgrade


echo_n "Installing apt-transport-https"
apt-get install apt-transport-https


############################## HIDDEN SERVICE CONFIGURATION ####################################
# Tor installation & hidden service creation
echo_n "Installing tor..."
sudo apt-get -y install tor

echo_n "Creating hidden service for ssh access..."
echo '# Hidden service for ssh' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_ssh/' >> /etc/tor/torrc
echo 'HiddenServicePort 22 127.0.0.1:22' >> /etc/tor/torrc

echo_n "Creating default hidden service for YunoHide..."
echo '# Default hidden service for YunoHide' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_default/' >> /etc/tor/torrc
echo 'HiddenServicePort 80 127.0.0.1:80' >> /etc/tor/torrc
echo 'HiddenServicePort 443 127.0.0.1:443' >> /etc/tor/torrc

# Email Ports
echo 'HiddenServicePort 25 127.0.0.1:25' >> /etc/tor/torrc
echo 'HiddenServicePort 465 127.0.0.1:465' >> /etc/tor/torrc
echo 'HiddenServicePort 587 127.0.0.1:587' >> /etc/tor/torrc
echo 'HiddenServicePort 993 127.0.0.1:993' >> /etc/tor/torrc

# XMPP Ports
echo 'HiddenServicePort 5222 127.0.0.1:5222' >> /etc/tor/torrc
echo 'HiddenServicePort 5269 127.0.0.1:5269' >> /etc/tor/torrc

# Cryptpad hidden service setup
echo_n "Creating default hidden service for CryptPad..."
echo '# Hidden service for Cryptpad' >> /etc/tor/torrc
echo 'HiddenServiceDir  /var/lib/tor/hidden_service_cryptpad/' >> /etc/tor/torrc
echo 'HiddenServicePort 80 127.0.0.1:80' >> /etc/tor/torrc
echo 'HiddenServicePort 443 127.0.0.1:443' >> /etc/tor/torrc

echo_n "Restarting tor..."
service tor restart
echo_n "waiting for tor to generate hidden services(60s)"
sleep 60

hidden_service_ssh="$(cat /var/lib/tor/hidden_service_ssh/hostname)"
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"
hidden_service_cryptpad="$(cat /var/lib/tor/hidden_service_cryptpad/hostname)"


############################## YUNOHOST POSTINSTALL ####################################
echo_n "Starting YunoHost post-install..."
yunohost tools postinstall -d "$hidden_service_default" -p "$PASSWORD" --ignore-dyndns

############################## FIREWALL UPDATE ####################################
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
yunohost firewall disallow TCP 25 --upnp-only --no-reload
yunohost firewall disallow TCP 53 --upnp-only --no-reload
yunohost firewall disallow TCP 80 --upnp-only --no-reload
yunohost firewall disallow TCP 443 --upnp-only --no-reload
yunohost firewall disallow TCP 465 --upnp-only --no-reload
yunohost firewall disallow TCP 587 --upnp-only --no-reload
yunohost firewall disallow TCP 993 --upnp-only --no-reload
yunohost firewall disallow TCP 5222 --upnp-only --no-reload
yunohost firewall disallow TCP 5269 --upnp-only --no-reload

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

# use own service configuration
wget https://github.com/code-a/yunohide/raw/master/yunohost.conf
cp ./yunohost.conf /etc/yunohost/yunohost.conf

# configure mailserver for internal use
# source: https://www.bentasker.co.uk/documentation/linux/161-configuring-postfix-to-block-outgoing-mail-to-all-but-one-domain
echo 'transport_maps = hash:/etc/postfix/transport' >> /etc/postfix/main.cf
hs_transport="$hidden_service_default"' :'
echo hs_transport >> /etc/postfix/transport
echo '* error: domain not allowed' >> /etc/postfix/transport
postmap /etc/postfix/transport
systemctl reload postfix


# configure xmpp-server for hidden services only
# source: https://gist.github.com/xnyhps/33f7de50cf91a70acf93
# //TODO: check if the directory is right
sudo curl -o "/usr/lib/metronome/modules/mod_onions.lua" "https://hg.prosody.im/prosody-modules/raw-file/tip/mod_onions/mod_onions.lua"
# //TODO: update template for metronome domains: https://github.com/YunoHost/yunohost/blob/1f6a57bc274a7a9c355206615e1ae674061d53b2/data/templates/metronome/domain.tpl.cfg.lua
# retrieve variables
main_domain=$(cat /etc/yunohost/current_host)
domain_list=$(sudo yunohost domain list --output-as plain --quiet)
# //TODO: metronome conf dir path!
metronome_conf_dir = 

for domain in $domain_list; do
    cat ./templates/metronome/domain.tpl.cfg.lua \
      | sed "s/{{ domain }}/${domain}/g" \
      > "${metronome_conf_dir}/${domain}.cfg.lua"
done

# //TODO: echo_n "Adding YunoHide AppsList"
# //TODO: add file with version info
# //TODO: yunohide-admin installation

############################## SERVER INFO ####################################
echo_g "\n\n\n###################################################"
echo_n "Finished YunoHide installation!\n"
echo_n "SSH-Address:"
echo_n "$hidden_service_ssh"
echo_n "YunoHost-Address:"
echo_n "$hidden_service_default"
echo_n "Please copy and save the addresses shown above."
echo_n "You need them to access your server from the internet!"
echo_g "###################################################\n\n"
read -rsp $'Press enter to finish setup...\n'



# Second update/upgrade to upgrade yunohost
#echo "updating package list"
#apt-get update

#echo "upgrading packages"
# //TODO: let user update system using webpanel
#apt-get install apt-transport-https
#apt-get upgrade --fix-missing






