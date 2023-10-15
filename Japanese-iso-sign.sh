#!/bin/bash

# 保存先フォルダ
artifacts=`pwd`/artifacts
repo_key=$(cat ~/.gnupg/sign.txt)
usb=/run/media/phoepsilonix/Ventoy

# GPG署名、SHA256SUMS、torrent
cd $artifacts

#sh rename.sh
echo "gpg sign"
# gpg署名
for f in *.iso firefox/*.iso
do
	[[ ! -e $f.sig ]] &&  { echo "gpg sign: $f" ; gpg --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
	if [[ ! -e $f.torrent ]] ;then
        echo "torrent"
	mktorrent -t0 \
        --announce=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,udp://tracker.openbittorrent.com:80/announce,udp://tracker.publicbt.com:80/announce \
		-w "https://sourceforge.net/projects/manjaro-jp/files/$f/download" \
		-w "https://manjaro-jp.phoepsilonix.love/$f" \
                $f -o $f.torrent
		#-w "https://osdn.net/projects/manjaro-jp/storage/$f" \
        fi
done

echo "sha256sums"
# チェック用ハッシュファイル
#find . -maxdepth 1 \( -name '*.iso' -or -name "*.sig" \) -type f -mmin -400 -printf '%f\n' \
#| xargs -I{} sha256sum {} >> SHA256SUMS
ls -1 *.iso *.sig firefox/*.iso firefox/*.sig > ~/.cache/mytmp1
cat SHA256SUMS | awk '{print $2}' > ~/.cache/mytmp2
files=($(diff -u ~/.cache/mytmp2 ~/.cache/mytmp1 | tail +4))
rm ~/.cache/mytmp1 ~/.cache/mytmp2

#files=(${files[@]/#@@?*})
#files=(${files[@]/#manjaro*})
#echo ${files[@]}
#files=(${files[@]/#firefox\/manjaro*})
#echo ${files[@]}
files=(${files[@]/#[!+-]*})
files=(${files[@]/#[+-][0-9]*})
#files=(${files[@]/\//\\/})
# check
#for f in ${files[@]}
#do
#        echo $f
#done

file=(${files[@]/#+*})
for f in ${file[@]}
do
        f=${f:1}
        echo - ${f}
        f=(${f/\//\\/})
        sed -i -e "/${f:1}/d" SHA256SUMS
done

file=(${files[@]/#-*})
for f in ${file[@]}
do
        echo + ${f:1}
        sha256sum ${f:1} >> SHA256SUMS
done

sort -k2 -u SHA256SUMS > tmp && mv tmp SHA256SUMS
#cp SHA256SUMS $usb/artifacts

#trackers=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' ../trackers_all.txt |sed -e 's/,$//')
#echo "torrent"
# torrentファイル作成
#for f in *.iso
#do
#	if [[ ! -e $f.torrent ]] ;then
#        echo $f
#	mktorrent -t0 \
#        --announce=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,udp://tracker.openbittorrent.com:80/announce,udp://tracker.publicbt.com:80/announce \
#		-w "https://sourceforge.net/projects/manjaro-jp/files/$f/download" \
#		-w "https://manjaro-jp.phoepsilonix.love/$f" \
 #               $f
		#-w "https://osdn.net/projects/manjaro-jp/storage/$f" \
#        fi
#done

        #--announce=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce,udp://tracker.openbittorrent.com:80/announce,udp://tracker.publicbt.com:80/announce,$trackers \

# 終了
echo "Done"

exit 0
