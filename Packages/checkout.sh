#!/bin/sh

curdir=${PWD##*/}
for m in $(cat ../extramodules.txt)
do
        # $mがなかったら、追加する。
        echo $m;
        [[ ! -e $m/ ]] && git submodule add ssh://git@gitlab.manjaro.org:22277/packages/extra/$curdir/$m $m;

        # masterブランチをchekoutして、pullでリモートの最新版を取得する
        cd $m;
        git checkout;
        git pull;
        cd ..;
done
 
exit 0
