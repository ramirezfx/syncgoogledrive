LOCALSYNCPATH=/home/lorenzomueller/GoogleDrive
REMOTE=GoogleDrive:
REMOTEPATH=/
while inotifywait -r -e modify,create,delete,move $LOCALSYNCPATH
do
        rclone bisync $REMOTE$REMOTEPATH $LOCALSYNCPATH --drive-skip-gdocs
done
