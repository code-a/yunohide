# Update

# Manual update needed...
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

echo_n "Reloading tor..."
echo_n "Your connection might break now..."
systemctl reload tor
echo_n "waiting for tor to generate hidden services(60s)"
sleep 60

# use own service configuration
wget https://github.com/code-a/yunohide/raw/master/yunohost.conf
cp ./yunohost.conf /etc/yunohost/yunohost.conf

# configure mailserver for internal use
# source: https://www.bentasker.co.uk/documentation/linux/161-configuring-postfix-to-block-outgoing-mail-to-all-but-one-domain
hidden_service_default="$(cat /var/lib/tor/hidden_service_default/hostname)"
echo 'transport_maps = hash:/etc/postfix/transport' >> /etc/postfix/main.cf
hs_transport="$hidden_service_default"' :'
echo hs_transport >> /etc/postfix/transport
echo '* error: domain not allowed' >> /etc/postfix/transport
postmap /etc/postfix/transport
systemctl reload postfix
