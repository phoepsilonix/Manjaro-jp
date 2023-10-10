#!/bin/sh

trackers=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' trackers_all.txt |sed -e 's/,$//')
MAGNET=""
cd artifacts
for f in *.torrent
do
    MAGNET+=" $(python ../torrent2magnet/torrent2magnet.py $f 2>/dev/null)"
done
cd ..
gpg -d ~/.ssh/pass.gpg | sudo -S choom -n -1000 -p $$
#--bt-seed-unverified=true \
#aria2c -V --seed-ratio=0.0 -c artifacts/*.torrent -dartifacts --enable-dht6 --enable-dht -j200 \
aria2c -V --seed-ratio=0.0 -c $MAGNET -T artifacts/*.torrent -dartifacts --enable-dht6 --enable-dht -j2 -x2 -s2 \
    --bt-seed-unverified=true \
--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce
#--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,$trackers

#--dht-listen-addr6=2406:8c00:0:3428:133:18:241:73 \
    #--bt-seed-unverified=true \
    #--follow-torrent=false \
