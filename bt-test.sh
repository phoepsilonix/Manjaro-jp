trackers=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' trackers_all.txt |sed -e 's/,$//')

#--bt-seed-unverified=true \
aria2c -V --seed-ratio=0.0 artifacts/*.torrent -dartifacts/ --enable-dht6 --enable-dht -j200 \
    --bt-seed-unverified \
--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,$trackers
