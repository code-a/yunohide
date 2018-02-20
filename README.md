# YunoHide

YunoHide configures a fresh installed YunoHost to serve all services as tor hidden services.

# Features

- [x] Install tor
- [x] Configure default hidden service for YunoHost apps
- [x] Configure hidden service for ssh access
- [ ] Change root password
- [ ] Close firewall ports

**Tested YunoHost version:**

  * yunohost-jessie-201701261126-sdraspi-stable.zip
    * YunoHost_v251_rpi.img

# Installation
## Requirements

  * Raspberry Pi(version 3 is recommended)
  * MicroSD-Card with [YunoHost Pi image](https://build.yunohost.org/yunohost-jessie-201701261126-sdraspi-stable.zip) installed

# Installation
## Boot your Pi
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
