DATE=$(date +%y%m%d)
DATE2=$(($DATE-1))
cp -afl artifacts/*$DATE*.iso ~/torrent_data/files/ || cp -afl artifacts/*$DATE2*.iso ~/torrent_data/files/
cp -afl artifacts/*$DATE*.iso.torrent ~/torrent_data/torrents/ || cp -afl artifacts/*$DATE2*.iso.torrent ~/torrent_data/torrents/
