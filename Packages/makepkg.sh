#!/bin/sh

curdir=${PWD##*/}
for m in $(cat ../extramodules.txt)
do
        cd $m;
        makepkg -sCc
        cd ..;
done
 
exit 0
