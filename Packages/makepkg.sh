#!/bin/sh

export IGNORE_CC_MISMATCH=1

curdir=${PWD##*/}
for m in $(cat ../extramodules.txt)
do
        cd $m;
        cat ~/.ssh/gpg-passphrase|sudo -S pwd > /dev/null
        yes | makepkg -sCc
        cd ..;
done
 
exit 0
