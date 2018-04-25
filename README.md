# YunoHide

YunoHide configures a fresh installed YunoHost to serve all services as tor hidden services.

**Project Status:** experimental & unstable

**Version:** 0.1.0

**Similar Projects:** [Tails Server](https://labs.riseup.net/code/issues/5688)

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
