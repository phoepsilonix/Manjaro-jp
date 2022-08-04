#!/bin/sh

curdir=${PWD##*/}

cd r8168
git diff | patch -R -i -
cd ../tp_smapi
git diff | patch -R -i -
cd ../broadcom-wl
git diff | patch -R -i -
cd ../virtualbox-modules
git diff | patch -R -i -
cd ..


for m in $(cat ../extramodules.txt)
do
        # $mがなかったら、追加する。
        echo $m;
        [[ ! -e ./$m/ ]] && (git submodule update --init $m || git submodule add ssh://git@gitlab.manjaro.org:22277/packages/extra/$curdir/$m $m;)

        # masterブランチをchekoutして、pullでリモートの最新版を取得する
        cd $m;
        git checkout master;
        git pull origin master;
        cd ..;
done
 
cd r8168
patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/r8168-extramodules.patch
cd ../tp_smapi
rm tp_smapi-clang.patch
patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/tp_smapi-build-with-clang.patch
cd ../broadcom-wl
patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/broadcom-wl-extramodule.patch
cd ../virtualbox-modules
patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/virtualbox-extramodule.patch

exit 0
