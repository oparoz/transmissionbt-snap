# TransmissionBT Snap

## Description

Download and share files using [transmissionbt](https://transmissionbt.com/) on Ubuntu Snappy.

**Has to be run in devmode.**

A good hardware companion for this Snap is the [Nextcloud Box](https://nextcloud.com/box) which comes with a 1TB hard drive and Nextcloud, a next-generation Files, Sync and Share solution.

## Compilation

*Prerequisite: You need to have both snapcraft and snapd installed. See https://snapcraft.io*

Download the source

`$ git clone https://github.com/oparoz/transmissionbt-snap`

Compile the snap

```
$ cd transmissionbt-snap
$ sudo snapcraft
```

Install it locally

`$ sudo snap install transmissionbt_1.0.0oparoz_amd64.snap --force-dangerous --devmode`

*Note: Replace the filename with the one which has been generated*

## Installation

This downloads the app from the Ubuntu app store

`$ sudo snap install transmissionbt --beta --devmode`

You can optionally relax the apparmor policy by typing:

`$ sudo snap connect transmissionbt:mount-observe ubuntu-core:mount-observe`

## How to use

### Web interface

Go with your browser to the URL of the device on which the snap was installed, but use port 9091.

Per example: `http://nextcloud.local:9091`

From there, you'll be able to:
* upload torrents file
* monitor download and seeding progress
* delete files

### Tools

The snap provides wget and p7zip to make it easier to fetch torrents and to unpack them using the command line or custom scripts.
Transmission can call a script each time a download is completed per example.

### Blocklist

The snap also provides a blocklist script which you can use to retrieve lists of IPs to block. 
The URL and list of files to download are blank, letting you pick what's best for your use-case.

## Files location

Place your torrents files here:

`/var/snap/transmissionbt/common/torrents`

*Note: It is advised to symlink this folder to another area of the system with easier access if you're not using the snap on Ubuntu Core*

The downloaded files are placed here:

`/var/snap/transmissionbt/common/downloads`

Files still being downloaded can be found here:

`/var/snap/transmissionbt/common/incomplete`

