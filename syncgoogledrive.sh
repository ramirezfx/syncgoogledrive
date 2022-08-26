#!/bin/bash
if pidof "rclone" >/dev/null; then
 echo "Sicherung läuft bereits"
else

 /usr/bin/rclone bisync GoogleDrive:/ /home/lorenzomueller/GoogleDrive/ --drive-skip-gdocs

# /usr/bin/rclone sync GoogleDrive:/ /home/lorenzomueller/GoogleDrive/
fi
