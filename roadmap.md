# Features
- [x] MailServer
- [x] XMPP-Server
- [ ] Mumble-Server
  * Apps
    * [ ] Nextcloud
    * [ ] Cryptpad
    * [ ] Zerobin
    * [ ] Web-Interface
  * Automatic configuration of 3 hidden services
    * [x] Main
    * [x] SSH
    * [ ] Cryptpad
- [x] Secure setup
    * Change root password
    * login using tor
    * Automatic YunoHost postinstall
    * Closes all Firewall ports except 22 for local network access

# Roadmap
## Version 0.1.0
- [x] Install tor
- [x] Configure default hidden service for YunoHost apps
- [x] Configure hidden service for ssh access
- [x] Change root password
- [x] Set YunoHost Admin password
- [x] Configure YunoHost(postinstall)
- [x] Close firewall ports
  - [ ] Except Port 22 for ssh

## Version 0.2.0 - April 2018
- [x] Allow custom service configuration(using yunohost.conf)
- [x] Mailserver for internal use
  - [x] ~~Anonymize Headers~~: Users can only access mailserver using tor
  - [x] Only Recipients at server allowed
  - [x] Hidden service ports: SMTP, IMAP, POP3
- [x] XMPP-Server
  - [x] Hidden service ports: XMPP
  - [x] mod_onions
- [x] Own AppsList


## Version 0.3.0 - Juni 2018
- [ ] ~~Mailserver for "public" use~~
- [ ] ~~Full Disk Encryption with unlock over ssh~~ Too complicated for end-users... only provide apss with at least encryption at rest
  - [ ] ~~https://hamy.io/post/0005/remote-unlocking-of-luks-encrypted-root-in-ubuntu-debian/~~
  - [ ] ~~https://paxswill.com/blog/2013/11/04/encrypted-raspberry-pi/~~
- [ ] ~~OnionConf~~
- [ ] Apps
  - [ ] Cryptpad with own hidden service domain
- [ ] YunoHide-Admin: WebPanel for administration
  


## Version 0.4.0 - September 2018
- [ ] Debian stretch support
- [ ] Encrypted backups with restic
- [ ] Own debian repo
- [ ] Own pi image
- [ ] Stronger ldap-hash algorithm: https://www.redpill-linpro.com/techblog/2016/08/16/ldap-password-hash.html
- [ ] OpenPGP KeyServer with WKD support: https://gist.github.com/kafene/0a6e259996862d35845784e6e5dbfc79

## Version 0.5.0 - November 2018
- [ ] YunoHide Moulinette Functions
  - [ ] hiddenservice_add (name, ports[])
  - [ ] hiddenservice_list (returns: (domain, name, ports[]))
  - [ ] hiddenservice_update (domain, name, ports[])
  - [ ] hiddenservice_delete (domain)


## Version 0.6.0 - Januar 2019


## Future
- [ ] Mailserver for "public" use
  - [ ] [Only accept onion domains as receivers](https://www.linuxquestions.org/questions/linux-server-73/how-to-reject-addresses-by-tld-in-postfix-678757/)
    * https://www.bentasker.co.uk/documentation/linux/161-configuring-postfix-to-block-outgoing-mail-to-all-but-one-domain
    * http://www.linuxmail.info/postfix-restrict-sender-recipient/
- [ ] VoIP
- [ ] ~~Nextcloud~~ 
  - [ ] with encryption enabled
  - [ ] with versioning disabled
  - [ ] with previews disabled: https://docs.nextcloud.com/server/10/admin_manual/configuration_server/config_sample_php_parameters.html#previews
  - [ ] with send_mail disabled
- [ ] [Torify Postfix](https://www.void.gr/kargig/blog/2014/05/10/smtp-over-hidden-services-with-postfix/)
- [ ] [Anonymize Headers](https://www.void.gr/kargig/blog/2013/11/24/anonymize-headers-in-postfix/)
  * https://www.bentasker.co.uk/documentation/linux/161-configuring-postfix-to-block-outgoing-mail-to-all-but-one-domain
  * http://www.linuxmail.info/postfix-restrict-sender-recipient/
