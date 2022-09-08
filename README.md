# syncgoogledrive
This script will sync your google drive with a local folder at your HDD every time the content of the synced folder changes
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

LOCALSYNCPATH (Your local directory to be synced - Example /home/user/Google

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


## Adding to startup

Look at your distro`s documentation where to setup the startup commands.
For startup-command of the script type in the command (Assuming /home/user/bin/syncgoogledrive.sh is the path to this script):

`bash -c "screen -S SyncGoogleDrive -dm bash /home/user/bin/syncgoogledrive.sh"`
