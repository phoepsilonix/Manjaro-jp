#!/bin/sh

# 保存先フォルダ
artifacts=`pwd`/artifacts

# torrent
cd $artifacts

echo "torrent"
rm *.torrent
# torrentファイル作成
for f in *.iso
do
	mktorrent -a udp://tracker.opentrackr.org:1337/announce \
		-a udp://tracker.torrent.eu.org:451 \
		-w  "https://sourceforge.net/projects/manjaro-jp/files/Manjaro-jp/$f/download" \
		-w "https://osdn.net/projects/manjaro-jp/storage/$f" $f
done

# 終了
echo "Done"

exit 0
