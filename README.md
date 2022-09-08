# syncgoogledrive
This script will sync your google drive with a local folder at your HDD hourly or when your PC wakes up from sleep-mode
Note: The Howto below must be executed as USER and NOT as root!

## Clone this repo
Install GIT

`sudo apt-get install git`

Clone this repo:

`git clone https://github.com/ramirezfx/syncgoogledrive.git`

Navigate to the local repo:

`cd syncgoogledrive`

Make the file executable:

`chmod 700 syncgoogledrive.sh`

Make a bin-folder inside your home-directory (Replace USERNAME with your username)

`mkdir ~/bin`

Copy the sync-file to the bin-directory:

`cp syncgoogledrive.sh ~/bin`

Open the file ~/syncgoogledrive.sh with your favourite editor and fill in all needed variables:

LOCALSYNCPATH (Your local files to be synced - Example /home/user/Google
REMOTE (The name your your remote - Example: GoogleDrive: - You can list your remotes by typing rclone listremotes)
REMOTEPATH (The path to be synced on the remote - Example / - This will sync your entire Google-Drive)

## Download/Intsall all needed software:

Rclone Download-Link:
https://downloads.rclone.org/
If you use debian-based distribution use can use this direct link to the latest-version:
https://downloads.rclone.org/rclone-current-linux-amd64.deb

Install Inotify-Tools and Screen:

`sudo apt-get install inotify-tools screen`

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

## Set up executing hourly-sync

Create the file for sync:

`echo '#!/bin/sh' > syncgoogledrive.sh`

`USERNAME=$(whoami);HOMEDIR=$(echo ~); echo /usr/sbin/runuser -l $USERNAME -c $HOMEDIR/bin/syncgoogledrive.sh >> syncgoogledrive.sh`

Change the ownership of the file to root:

`sudo chown root syncgoogledrive.sh`

Change the group to root:

`sudo chgrp root syncgoogledrive.sh`

Make the file executable:

`sudo chmod a+x syncgoogledrive.sh`

Move the file to the hourly cron to sync hourly:

`sudo mv syncgoogledrive.sh /etc/cron.hourly`

## Set up executing sync on wake up from sleep

Create the file 99syncdrive.sh with the sync commands by typing:

`echo '#!/bin/sh' > 99syncdrive.sh`

`echo 'case $1/$2 in' >> 99syncdrive.sh`

`echo 'post/*)' >> 99syncdrive.sh`

`USERNAME=$(whoami);HOMEDIR=$(echo ~);sudo echo /usr/sbin/runuser -l $USERNAME -c "'"$HOMEDIR/bin/syncgoogledrive.sh"'" >> 99syncdrive.sh`

`echo ';;' >> 99syncdrive.sh`

`echo 'esac' >> 99syncdrive.sh`


Change the owner of the file to root:


`sudo chown root 99syncdrive.sh`


Change the group of the file to root:


`sudo chgrp root 99syncdrive.sh`


Make the file executable:


`sudo chmod a+x 99syncdrive.sh`

Move the file to the directory /lib/systemd/system-sleep

`sudo mv 99syncdrive.sh /lib/systemd/system-sleep`
