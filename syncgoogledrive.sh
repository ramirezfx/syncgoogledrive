#!/bin/bash
LOCKFILE=/home/lorenzomueller/bin/googlesync.lock
REMOTEDIR=GoogleDrive
LOCALDIR=/home/lorenzomueller/GoogleDrive
if test -f "$LOCKFILE"; then
 echo "Sicherung läuft bereits"
else
touch $LOCKFILE
 /usr/bin/rclone bisync $REMOTEDIR:/ $LOCALDIR --drive-skip-gdocs
rm $LOCKFILE
fi
