#!/bin/sh

. ../../keychain.sh

curdir=${PWD##*/}
exdir=$(cat /usr/lib/modules/${curdir}-MANJARO/version)
exdir=/usr/lib/modules/${exdir}/build
echo $exdir
ver=${curdir/extramodules-}
kver=${curdir/extramodules-}
if [[ "$ver" == "6.1" ]] ;then ver=5.15
elif [[ "$ver" == "5.10" ]] ;then ver=6.1
else ver=6.1
fi

gpg -dq ~/.ssh/pass.gpg | sudo -S pwd >/dev/null
sudo chown -R phoepsilonix:phoepsilonix $exdir
#cd r8168
#git diff | patch -R -i -
#cd ../tp_smapi
#git diff | patch -R -i -
#cd ..
#cd tp_smapi
#rm tp_smapi-clang.patch
#cd ..
#
#for m in "nvidia-390xx" "nvidia-470xx"
for m in $(cat ../extramodules.txt)
do
        # $mがなかったら、追加する。
        echo $m;
        [[ ! -e ./$m/ ]] && (git submodule update --init $m || git submodule add ssh://git@gitlab.manjaro.org:22277/packages/extra/$curdir/$m $m || continue;)

        # masterブランチをchekoutして、pullでリモートの最新版を取得する
        cd $m || continue
        
        git clean -d -f -e .*\.patch
        #git diff --binary HEAD | git apply --check --stat --apply --allow-empty -R -
        git reset --hard master
        git switch master
        git reset --hard HEAD~
        git pull
        #git checkout master;
        #git switch -f master
        #git pull origin master
        case "$kver" in
            "6.4" ) 
                patches="patch-*${m}-linux6.4\.patch" ;;
            "6.1" ) 
                patches="patch-*${m}-linux6.1\.patch" ;;
            * ) 
                patches="patch-*${m}\.patch" ;;
        esac
        case "$m" in
            "tp_smapi" ) patches="patch-*${m}\.patch"
                case "$kver" in
                    "6.4" ) 
                        patches="patch-*${m}-linux6.4\.patch" ;;
                esac
        esac
        #if [[ ! -e $patches ]];then
        #    patches="patch-*${m}\.patch"
        #fi
        for patch in ~/gitlab/Manjaro-jp/patches/kmod-*${m}\.patch ~/gitlab/Manjaro-jp/patches/${patches}
        do
            echo $patch
            echo
                if [[ -e $patch ]];then
                        echo "$patch Applying"
                        git apply --check --stat --apply $patch
                fi
        done
        files=$(ls ../../extramodules-$ver/$m/*.{gz,zip,asc,xz,run,bz2} 2>/dev/null)
        for f in $files
        do
            if [[ -f $f ]] ;then
                echo ln $f ./
                ln $f ./
            fi
        done
        cd ..;
done
 
#cd r8168
#patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/r8168-extramodules.patch
#updpkgsums
#cd ../tp_smapi
#rm tp_smapi-clang.patch
#patch -i /home/phoepsilonix/gitlab/Manjaro-jp/patches/tp_smapi-build-with-clang.patch

exit 0
