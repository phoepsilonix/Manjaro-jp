#!/bin/bash

# 保存先フォルダ
artifacts=`pwd`/artifacts
repo_key=$(cat ~/.gnupg/sign.txt)
usb=/run/media/phoepsilonix/Ventoy

# GPG署名、SHA256SUMS、torrent
cd $artifacts

sh rename.sh
echo "gpg sign"
# gpg署名
for f in *.iso
do
	[[ ! -e $f.sig ]] &&  { echo "gpg sign: $f" ; gpg --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
done

echo "sha256sums"
# チェック用ハッシュファイル
#find . -maxdepth 1 \( -name '*.iso' -or -name "*.sig" \) -type f -mmin -400 -printf '%f\n' \
#| xargs -I{} sha256sum {} >> SHA256SUMS
ls -1 *.iso *.sig > ~/.cache/mytmp1
cat SHA256SUMS | awk '{print $2}' > ~/.cache/mytmp2
files=($(diff -u ~/.cache/mytmp2 ~/.cache/mytmp1 | tail +4))
rm ~/.cache/mytmp1 ~/.cache/mytmp2

files=(${files[@]/#@@})
files=(${files[@]/#[+-][0-9]*})
files=(${files[@]/#manjaro*})

# check
#for f in ${files[@]}
#do
#        echo $f
#done

file=(${files[@]/#+*})
for f in ${file[@]}
do
        echo ${f:1}
        sed -i -e "/${f:1}/d" SHA256SUMS
done

file=(${files[@]/#-*})
for f in ${file[@]}
do
        echo ${f:1}
        sha256sum ${f:1} >> SHA256SUMS
done

sort -k2 -u SHA256SUMS > tmp && mv tmp SHA256SUMS
cp SHA256SUMS $usb/artifacts

echo "torrent"
# torrentファイル作成
for f in *.iso
do
	[[ ! -e $f.torrent ]] && \
	mktorrent -a udp://tracker.opentrackr.org:1337/announce \
		-a udp://tracker.torrent.eu.org:451 \
		-w "https://sourceforge.net/projects/manjaro-jp/files/$f/download" \
		-w "https://osdn.net/projects/manjaro-jp/storage/$f" $f 
done

# 終了
echo "Done"

exit 0
