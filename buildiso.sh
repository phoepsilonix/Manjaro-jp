#!/bin/sh
#
NO_OOM_KILLER="$$"
source ./keychain.sh
gpg -dq ~/.ssh/pass.gpg|sudo -S pwd
echo "start"
gpg -dq ~/.ssh/pass.gpg|sudo -S choom -n -1000 -p $$
#sudo rm /var/lib/manjaro-tools/buildiso/* -rf

# 参照するiso-profilesはカレントディレクトリが優先される。
pkgs=`pwd`/Japanese-pkgs.txt
pkgs2=`pwd`/Japanese-pkgs-root.txt
pkgdir=`pwd`/iso-profiles
usb=/run/media/phoepsilonix/Ventoy
gkey="-g $(cat ~/.gnupg/sign.txt)"
#gkey=""

kernel=linux613

# 保存先フォルダ
artifacts=`pwd`/artifacts

# 日本語パッケージを加えるファイル
#pkg1=Packages-Live
pkg2=Packages-Desktop
pkg3=Packages-Root

# エディション指定
editions=(
       "manjaro gnome"
       "manjaro kde"
#        "manjaro gnome-next"
       "manjaro xfce"
       "manjaro architect"
        "community cinnamon"
#        "community mate"
       # "community openbox"
#	"community lxqt"
#	"community lxqt-kwin"
#	"community sway"
#	"community budgie"
#	"manjaro netinstall"
)

# 初期化
#rm -rf $artifacts
#mkdir -p $artifacts
rm -rf $pkgdir
#mkdir -p $pkgdir
cp -a iso-profiles-orig $pkgdir
cp -r iso-profiles-orig/shared $pkgdir/
sync

# profiles.confを微修正
# user-repos.confを追加したiso-profilesを用意する

#rm -r "$pkgdir/shared/"
#cp -r iso-profiles-orig/shared "$pkgdir/"
sync
# add Japanese pkgs and vivaldi
for edition in "${editions[@]}"
do
	data=(${edition[@]})
	path=${data[0]}/${data[1]}
        mkdir -p $pkgdir/$path/
        rm -r "$pkgdir/${data[0]}/${data[1]}"
        #echo rm -rf "$pkgdir/$path/*"
        #rm -rf "$pkgdir/$path/*"
        sync
        echo cp -r iso-profiles-orig/$path "$pkgdir/${data[0]}/"
        cp -r iso-profiles-orig/$path "$pkgdir/${data[0]}/"
	#cat $pkgs >> $pkgdir/$edition[0]/$edition[1]/$pkg1
	# Desktopパッケージに加える。ライブは不要みたい。
        if [[ "${data[1]}" != "architect" ]] ;then
            echo ${data[1]}
            echo "cat $pkgs >> $pkgdir/$path/$pkg2"
            cat $pkgs >> $pkgdir/$path/$pkg2
        fi
        # Packages-Rootに追加
            echo "cat $pkgs2 >> $pkgdir/$path/$pkg3"
            cat $pkgs2 >> $pkgdir/$path/$pkg3
            #if [[ "${data[1]}" != "gnome" && "${data[1]}" != "kde" ]] ;then
            #    echo "manjaro-asian-input-support-ibus" >> $pkgdir/$path/$pkg2
            #fi
        sync
done

# buildiso prepare image
echo "build image"
for edition in "${editions[@]}"
do
	data=(${edition[@]})
	ed=${data[1]}
        echo $data
        echo $ed
        gpg -dq ~/.ssh/pass.gpg|sudo -S pwd >/dev/null 2>&1
        sudo rm /var/lib/manjaro-tools/buildiso/$ed -rf
        sync
#        echo "build pre-image"
#        echo "buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso -r $usb/tmp/build"
#        buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso 
#        buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso -r $usb/tmp/build
        echo "build iso"
        gpg -dq ~/.ssh/pass.gpg|sudo -S pwd >/dev/null
        touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback -b INFO
        sync
        echo buildiso -o -d xz -f -k $kernel -p $ed $gkey
        buildiso -o -d xz -f -k $kernel -p $ed $gkey && ./line-notify.sh "$ed done" || ./line-notify.sh "$ed error" 
        #buildiso  -zc -d xz -f -k $kernel -p $ed $gkey && ./line-notify.sh "$ed done" || ./line-notify.sh "$ed error" 
        sync
        #gpg -dq ~/.ssh/pass.gpg|sudo -S pwd >/dev/null
        #touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/gpg-passphrase --batch --pinentry-mode=loopback -b INFO
        #echo buildiso -zc -o -d xz -f -k $kernel -p $ed $gkey
        #buildiso -zc -o -d xz -f -k $kernel -p $ed $gkey && ./line-notify.sh "$ed done" || ./line-notify.sh "$ed error" 
        sync
        find /var/cache/manjaro-tools/iso -type f -name "*.iso" | xargs -I{} mv {} $artifacts && sync
        . artifacts/rename.sh
#        buildiso -x -d xz -f -k $kernel -p $ed $gkey -t $usb/tmp/iso 
#        buildiso -zc -d xz -f -k $kernel -p $ed $gkey
        #buildiso -d xz -f -k $kernel -p $ed -zc $gkey -t $usb/tmp/iso -r $usb/tmp/build
        gpg -dq ~/.ssh/pass.gpg|sudo -S pwd >/dev/null 2>&1
        sudo rm /var/lib/manjaro-tools/buildiso/$ed -rf
        sync
done

echo "Move iso files to Artifacts folder"
#sudo chown -R phoepsilonix:phoepsilonix $usb/tmp/iso/
sync
find /var/cache/manjaro-tools/iso -type f -name "*.iso" | xargs -I{} mv {} $artifacts && sync
#rsync -avn $usb/artifacts/*.iso $artifacts/ && sync
        sync

# 終了
echo "Done"

exit 0
