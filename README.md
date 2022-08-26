# syncgoogledrive
This script will sync your google drive with a local folder at your HDD hourly or when your PC wakes up from sleep-mode

## Download the latest version of rclone and install it

Download-Link:
https://downloads.rclone.org/
If you use debian-based distribution use can use this direct link to the latest-version:
https://downloads.rclone.org/rclone-current-linux-amd64.deb

## Set up the connection to your Google-Drive:

`rclone config`

You can list your remote(s) with this command:

`rclone listremotes`

## Do an initial sync to your local directory:

`rclone sync REMOTE:PATH LOCALDIR --drive-skip-gdocs`

Example:
Assuming your REMOTE is GoogleDrive and your Local Directory is /home/user/Google

`rclone sync GoogleDrive:/ /home/user/Google --drive-skip-gdocs`

(Notice that we sync the complete Google-Drive with GoogleDrive:/ - If you use for example only the directory TEST of your Google drive use GoogleDrive:/TEST instead)

## Do an initial bi-directional sync:

`rclone bisync REMOTE:PATH LOCALDIR --drive-skip-gdocs --resync`

Once the initial bi-directional sync is working, you can sync it now with this command:

`rclone bisync REMOTE:PATH LOCALDIR --drive-skip-gdocs`

## Set up executing on wake up from sleep

Naviate to the directory /lib/systemd/system-sleep by typing:

`cd /lib/systemd/system-sleep`

Create the file 99syncdrive.sh with the sync commands by typing (Replace USERNAME with your username and YOURHOMEDIR with the path to your home-directory:

`sudo echo '!/bin/sh' > 99syncdrive.sh`

`sudo echo 'case $1 in' >> 99syncdrive.sh`

`sudo echo 'post)' >> 99syncdrive.sh`

`sudo echo "runuser -l USERNAME -c '/home/YOURHOMEDIR/bin/syncgoogledrive.sh'" >> 99syncdrive.sh`

`sudo echo ';;' >> 99syncdrive.sh`

`sudo echo 'esac' >> 99syncdrive.sh`


Change the owner of the file to root:


`sudo chown root 99syncdrive.sh`


Change the group of the file to root:


`sudo chgrp root 99syncdrive.sh`


Make the file executable:


`sudo chmod a+x 99syncdrive.sh`
