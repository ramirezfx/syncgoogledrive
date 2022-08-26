# syncgoogledrive

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
