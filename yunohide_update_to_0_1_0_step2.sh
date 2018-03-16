hidden_service_cryptpad="$(cat /var/lib/tor/hidden_service_cryptpad/hostname)"
yunohost domain add "$hidden_service_cryptpad"
