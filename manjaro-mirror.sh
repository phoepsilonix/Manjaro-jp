#!/bin/bash

# This script should be a cronjob and should be run a few times a day. (example for /etc/crontab: "0  *  *  *  * root /usr/bin/manjaroreposync").
# However you can also move this script to "/etc/cron.hourly".
# To be an official Manjaro Linux mirror and to get access to our rsync server, you have to tell us your static ip of your synchronization server.

SRC=rsync://ftp.tsukuba.wide.ad.jp/manjaro/
DESTPATH="/home/phoepsilonix/work/manjaro/"
RSYNC=/usr/bin/rsync
LOCKFILE=/tmp/rsync-manjaro.lock



synchronize() {
    $RSYNC -rtlvH --delete-after --delay-updates --safe-links "$SRC" "$DESTPATH" --exclude=arm-*/ --exclude=sync-arm/* --exclude=overlay-arm/*

}



if [ ! -e "$LOCKFILE" ]
then
    echo $$ >"$LOCKFILE"
    synchronize
else
    PID=$(cat "$LOCKFILE")
    if kill -0 "$PID" >&/dev/null
    then
        echo "Rsync - Synchronization still running"
        exit 0
    else
        echo $$ >"$LOCKFILE"
        echo "Warning: previous synchronization appears not to have finished correctly"
        synchronize
    fi
fi

rm -f "$LOCKFILE"
