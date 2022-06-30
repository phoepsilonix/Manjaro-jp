#!/bin/sh

export IGNORE_CC_MISMATCH=1

curdir=${PWD##*/}
for m in $(cat ../extramodules.txt)
do
        cd $m;
        makepkg -sCc
        cd ..;
done
 
exit 0
