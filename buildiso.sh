#!/bin/sh

# 参照するiso-profilesはカレントディレクトリが優先される。
pkgs=`pwd`/Japanese-pkgs.txt
pkgdir=`pwd`/iso-profiles
usb=/run/media/phoepsilonix/Ventoy
gkey="-g $(cat ~/.gnupg/sign.txt)"

kernel=linux64

# 保存先フォルダ
artifacts=`pwd`/artifacts

# 日本語パッケージを加えるファイル
#pkg1=Packages-Live
pkg2=Packages-Desktop

# エディション指定
editions=(
	"manjaro gnome"
	"manjaro kde"
	"manjaro xfce"
	"community cinnamon" 
        "community mate"
#	"community lxqt"
#	"community cutefish"
#	"community i3"
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
done

# buildiso prepare image
echo "build image"
for edition in "${editions[@]}"
do
	data=(${edition[@]})
	ed=${data[1]}
        #echo "build pre-image"
        #buildiso -d xz -f -k $kernel -p $ed -x -v $gkey -t $usb/tmp/iso
        #buildiso -d xz -f -k $kernel -p $ed -x -v $gkey -t $usb/tmp/iso -r $usb/tmp/build
        echo "build iso"
        buildiso -d xz -f -k $kernel -p $ed -zc -v $gkey -t $usb/tmp/iso
        #buildiso -d xz -f -k $kernel -p $ed -zc -v $gkey -t $usb/tmp/iso -r $usb/tmp/build
done

echo "Move iso files to Artifacts folder"
sync
find $usb/tmp/iso -type f -name "*.iso" | \
    xargs -I{} cp {} $artifacts && sync

# 終了
echo "Done"

exit 0
