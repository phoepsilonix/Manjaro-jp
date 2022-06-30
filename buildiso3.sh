#!/bin/sh

# 参照するiso-profilesはカレントディレクトリが優先される。
pkgs=`pwd`/Japanese-pkgs.txt
pkgs2=`pwd`/Japanese-pkgs-root.txt
pkgdir=`pwd`/iso-profiles
usb=/run/media/phoepsilonix/Ventoy
gkey="-g $(cat ~/.gnupg/sign.txt)"
#gkey=""

kernel=linux518

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
	"manjaro xfce"
#	"community cinnamon" 
#       "community mate"
#	"community lxqt"
#	"community lxqt-kwin"
)

# 初期化
#rm -rf $artifacts
mkdir -p $artifacts
rm -rf $pkgdir
mkdir -p $pkgdir

# profiles.confを微修正
# user-repos.confを追加したiso-profilesを用意する
cp -r iso-profiles-orig/* $pkgdir

# add Japanese pkgs and vivaldi
for edition in "${editions[@]}"
do
	data=(${edition[@]})
	path=${data[0]}/${data[1]}
	#cat $pkgs >> $pkgdir/$edition[0]/$edition[1]/$pkg1
	# Desktopパッケージに加える。ライブは不要みたい。
	cat $pkgs >> $pkgdir/$path/$pkg2
        # Packages-Rootに追加
	cat $pkgs2 >> $pkgdir/$path/$pkg3
done

# buildiso prepare image
echo "build image"
for edition in "${editions[@]}"
do
	data=(${edition[@]})
	ed=${data[1]}
#        echo "build pre-image"
#        echo "buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso -r $usb/tmp/build"
#        buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso 
#        buildiso -d xz -f -k $kernel -p $ed -x $gkey -t $usb/tmp/iso -r $usb/tmp/build
        echo "build iso"
        echo "buildiso -d xz -f -k $kernel -p $ed -zc $gkey -t $usb/tmp/iso -r $usb/tmp/build"
        buildiso -d xz -f -k $kernel -p $ed -zc $gkey -t $usb/tmp/iso 
        #buildiso -d xz -f -k $kernel -p $ed -zc $gkey -t $usb/tmp/iso -r $usb/tmp/build
done

echo "Move iso files to Artifacts folder"
#sudo chown -R phoepsilonix:phoepsilonix $usb/tmp/iso/
sync
find $usb/tmp/iso -type f -name "*.iso" | xargs -I{} mv {} $usb/artifacts/ && sync
#rsync -avn $usb/artifacts/*.iso $artifacts/ && sync
sync

# 終了
echo "Done"

exit 0
