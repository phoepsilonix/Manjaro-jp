#!/bin/sh

# 参照するiso-profilesはカレントディレクトリが優先される。
pkgs=`pwd`/Japanese-pkgs.txt
pkgdir=`pwd`/iso-profiles

kernel=linux517

# 保存先フォルダ
artifacts=`pwd`/artifacts

# 日本語パッケージを加えるファイル
#pkg1=Packages-Live
pkg2=Packages-Desktop

# エディション指定
editions=(
	"manjaro gnome"
#	"manjaro kde"
#	"manjaro xfce"
#	"community cinnamon" 
#	"community i3"
#	"community lxqt"
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
        buildiso -d xz -f -k $kernel -o -p $ed -x -v -t ./
done

# build iso
echo "build iso"
for edition in  "${editions[@]}"
do
	data=(${edition[@]})
	ed=${data[1]}
	echo $ed
	buildiso -d xz -f -k $kernel -o -p $ed -zc -v -t ./
done

echo "Move iso files to Artifacts folder"
find ./manjaro/ ./community/ -type f -name "*.iso" | \
    xargs -I{} mv {} $artifacts && sync

# 終了
echo "Done"

exit 0
