# Update
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
echo_n "Your connection might break now..."
echo_n "Continue with yunohide_update_to_0_1_0_step2.sh afterwards"
service tor restart
echo_n "waiting for tor to generate hidden services(60s)"
sleep 60
