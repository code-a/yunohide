# YunoHide

YunoHide configures a fresh installed YunoHost to serve all services as tor hidden services.

Version: 0.1.0

# Features
  * Apps
    * [ ] Nextcloud
    * [ ] Cryptpad
    * [ ] Mailserver
    * [ ] XMPP-Server
    * [ ] Web-Interface
  * Automatic configuration of 3 hidden services
    * [x] Main
    * [x] SSH
    * [ ] Cryptpad
  * Secure setup
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

## Version 0.2.0
- [ ] Mailserver
  - [ ] [Torify Postfix](https://www.void.gr/kargig/blog/2014/05/10/smtp-over-hidden-services-with-postfix/)
  - [ ] [Anonymize Headers](https://www.void.gr/kargig/blog/2013/11/24/anonymize-headers-in-postfix/)
  - [ ] [Only accept onion domains as receivers](https://www.linuxquestions.org/questions/linux-server-73/how-to-reject-addresses-by-tld-in-postfix-678757/)
    * https://www.bentasker.co.uk/documentation/linux/161-configuring-postfix-to-block-outgoing-mail-to-all-but-one-domain
    * http://www.linuxmail.info/postfix-restrict-sender-recipient/
  - [x] Hidden service ports: SMTP, IMAP, POP3
- [x] XMPP-Server
  - [x] Hidden service ports: XMPP

## Version 0.3.0
- [ ] Own AppsList
  - [ ] Nextcloud with encryption enabled
  - [ ] Cryptpad with own hidden service domain
  - [ ] WifiHotspot with \*.local domain
- [ ] YunoHide Moulinette Functions
  - [ ] hiddenservice_add (name, ports[])
  - [ ] hiddenservice_list (returns: (domain, name, ports[]))
  - [ ] hiddenservice_update (domain, name, ports[])
  - [ ] hiddenservice_delete (domain)
- [ ] YunoHide-Admin



**Tested YunoHost version:**

  * yunohost-jessie-201701261126-sdraspi-stable.zip
    * YunoHost_v251_rpi.img

# Requirements

  * Raspberry Pi(version 3 is recommended)
  * MicroSD-Card flashed with [YunoHost Pi image](https://build.yunohost.org/yunohost-jessie-201701261126-sdraspi-stable.zip)

# Installation

## Preparation
Insert the SD-card into your computer and create an empty file with filename **ssh** in the boot partition.

**Note:** The file **MUST NOT** have a filename-extension

## Boot your Pi
  - Insert the SD-card into your raspberry pi
  - Boot your raspberry pi connected to your router
  - Wait 10 minutes to give the pi time to setup correctly

## Connect to your raspberry pi with another computer in your home network
Try to connect to your pi using the following command in your terminal:

    ssh root@YunoHost.local

If this does not work you have to [find the IP of your raspberry pi](https://yunohost.org/#/ssh).
Connect to the pi using it's IP:

    ssh root@XXX.XXX.XXX.XXx

**Password:** The root password is **yunohost**.

## Install YunoHide
After you have connected to your raspberry pi, run the following commands in your SSH session:

    wget https://github.com/nebulak/yunohide/raw/master/yunohide_install.sh
    chmod +x yunohide_install.sh
    ./yunohide_install.sh

At the end of the installation the hidden service addresses are shown, as in the example below:

    //TODO: yunohide info screenshot

**Finished!** You should now have a YunoHost installation, which is only available from inside the tor network.
