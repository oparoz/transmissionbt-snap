# TransmissionBT Snap

## Description

Download and share files using [transmissionbt](https://transmissionbt.com/) on Ubuntu Snappy.

**Has to be run in devmode.**

A good hardware companion for this Snap is the [Nextcloud Box](https://nextcloud.com/box) which comes with a 1TB hard drive and Nextcloud, a next-generation Files, Sync and Share solution.

## Authors

* [Olivier Paroz](https://github.com/oparoz)

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

`$ sudo snap install transmissionbt_1.0.1oparoz_amd64.snap --force-dangerous --devmode`

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

You can find the script here:

`/var/snap/transmissionbt/current/transmission/blocklists.sh`

Once you've updated the blocklist, simply restart the service

`$ sudo systemctl restart snap.transmissionbt.transmission-daemon`

*Note: It takes a while as your blocklists will need to be downloaded and unpacked*

Go to the web interface, click on the "wrench" button (bottom left), go to the "Peers" tab.
You should see a high number of rules.

## Files location

Place your torrents files here:

`/var/snap/transmissionbt/common/torrents`

*Note: It is advised to symlink this folder to another area of the system with easier access if you're not using the snap on Ubuntu Core*

The downloaded files are placed here:

`/var/snap/transmissionbt/common/downloads`

Files still being downloaded can be found here:

`/var/snap/transmissionbt/common/incomplete`

## Creating torrents

Create the torrent

```
$ sudo transmissionbt.transmission-create -o ~/torrents/transmissionbt_1.0.1oparoz_amd64.snap.torrent -c "transmissionbt Snap for Ubuntu Snappy" -t udp://tracker.openbittorrent.com:80 -t udp://open.demonii.com:1337 -t udp://tracker.coppersurfer.tk:6969 -t udp://tracker.leechers-paradise.org:6969 ~/sharing/transmissionbt_1.0.1oparoz_amd64.snap
```

### Explanations

Torrent to create, including the full path to its location

`-o ~/torrents/transmissionbt_1.0.1oparoz_amd64.snap.torrent`

Comments you want to add to the file

`-c "transmissionbt Snap for Ubuntu Snappy"`

As many trackers as you want. Use more than one for redundancy

```
-t udp://tracker.openbittorrent.com:80
-t udp://open.demonii.com:1337
-t udp://tracker.coppersurfer.tk:6969
-t udp://tracker.leechers-paradise.org:6969
```

File or directory to share

`~/sharing/transmissionbt_1.0.1oparoz_amd64.snap`

## Seeding

Copy both the files/folder to your transmission download folder

```
$ sudo cp ~/downloads/transmissionbt_1.0.1oparoz_amd64.snap /var/snap/transmissionbt/common/downloads/
```

Send the torrent file to transmission

*Note: Authentication is required when using transmission-remote. The default login/password are transmission/transmission*

```
$ sudo transmissionbt.transmission-remote -n 'transmission:transmission' -a ~/torrents/transmissionbt_1.0.1oparoz_amd64.snap.torrent
localhost:9091/transmission/rpc/ responded: "success"
```

## Monitoring

List all torrents

```
$ sudo transmissionbt.transmission-remote -n 'transmission:transmission' -l
ID     Done       Have  ETA           Up    Down  Ratio  Status       Name
   1   100%   11.47 MB  Done         0.0     0.0    0.0  Idle         transmissionbt_1.0.1oparoz_amd64.snap
Sum:          11.47 MB               0.0     0.0
```
