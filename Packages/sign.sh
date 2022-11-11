#!/bin/sh

repo_key=$(cat ~/.gnupg/sign.txt)
curdir=${PWD##*/}
for m in $(cat ../extramodules.txt)
do
        cd $m;
# 署名がないパッケージに署名をする
for f in *.zst 
do
	[[ ! -f "$f.sig" ]] && { echo "gpg sign: $f" ; gpg --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
done

# パッケージの署名の検証
for f in *.zst.sig 
do
	echo "$f ${f%.*} gpg verify"
	gpg -v --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
done
        cd ..;
done
 
exit 0

