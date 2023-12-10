#!/bin/sh

#trackers=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' -e 's/,,/,/g' trackers_all.txt |sed -e 's,$//')
trackers=$(sed -e '/^$/d' trackers_all.txt trackers_all_ip.txt trackers_best.txt| sort | uniq | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' -e 's/,,/,/g' -e's/,$//')
#MAGNET=""
#TORRENT=$(ls artifacts/*.torrent |xargs -n1 echo -n " -T ")
TORRENT=$(ls $(pwd)/artifacts/*.torrent)
#TORRENT2=$(ls artifacts/firefox/*.torrent)
PARALLEL=$(($(ls artifacts/*.torrent |wc -l)*4))
#PARALLEL2=$(($(ls artifacts/firefox/*.torrent |wc -l)*4))
ARTIFACTS=$(pwd)/artifacts/
#for f in $TORRENT
#do
#    MAGNET+=" $(python torrent2magnet/torrent2magnet.py $f 2>/dev/null)"
#done
gpg -d ~/.ssh/pass.gpg | sudo -S choom -n -1000 -p $$
pid=$(pgrep aria2c)
[[ -n "$pid" ]] && echo "kill" $pid && kill $pid && sleep 3
#--bt-seed-unverified=true \
#aria2c -V --seed-ratio=0.0 -c $MAGNET -T artifacts/*.torrent -dartifacts --enable-dht6 --enable-dht -j2 -x2 -s2 \
#aria2c -V --seed-ratio=0.0 -T artifacts/*.torrent -dartifacts --enable-dht6 --enable-dht -j2 -x2 -s2 \
#aria2c -V --seed-ratio=0.0 -c artifacts/*.torrent -dartifacts --enable-dht6 --enable-dht -j2 -x2 -s2 \
#nohup qbittorrent-nox -d $TORRENT --save-path=./artifacts/ >/dev/null 2>&1 &
#nohup qbittorrent-nox -d $TORRENT --torrenting-port=6881 >/dev/null 2>&1 &

#<< COMMENT
aria2c -V --seed-ratio=0.0 -j$PARALLEL -x2 -s2 -P -c $TORRENT -d$ARTIFACTS --enable-dht6 --enable-dht \
    --bt-seed-unverified=true \
    --dht-listen-port=6881 --dht-message-timeout=10 \
    --listen-port=6889 \
    -D \

#    --bt-seed-unverified=true -D

#   --conf $(pwd)/aria2.conf
#COMMENT
#--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,$trackers >/dev/null 2>&1 &

#nohup aria2c -V --seed-ratio=0.0 -j$PARALLEL2 -x2 -s2 -Z -P -c $TORRENT2 -dartifacts/firefox --enable-dht6 --enable-dht \
#    --bt-seed-unverified=true \
#--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,$trackers >/dev/null 2>&1 &
#--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce \

#--dht-listen-addr6=2406:8c00:0:3428:133:18:241:73 \
    #--bt-seed-unverified=true \
    #--follow-torrent=false \
