#!/bin/sh
#set -eux

repo_dir=./artifacts/manjaro-jp/
cd $repo_dir;

# localhostsのレポジトリを更新 
echo "localhost"
sudo rsync -av --delete ./ /root/manjaro-jp/ || { echo "rsync to local backup error" ; exit 1 ; }

# USBへバックアップ
echo "usb"
usb=/run/media/phoepsilonix/Ventoy
#rsync -aLv ../../artifacts/ $usb/artifacts/

# OSDNへアップデート
echo "OSDN"
rsync -rLtgoDv --partial --no-perms --progress --delete ./*.sig ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -rLtgoDv --partial --no-perms --progress --delete ../*.sig ../*.md ../SHA256SUMS phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# torrentファイルはisoのあとにアップロードさせる。
rsync -rLtgoDv --partial --size-only --no-perms --delete --progress ../*.iso phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -rLtgoDv --partial --no-perms --progress --delete ../*.torrent phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# 残りをまともて高速チェックでアップロード
rsync -rLtgoDv --partial --size-only --no-perms --delete --progress ../ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -aLv --partial --no-perms --progress  ../README.md ../README.en.md ../README.ja.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/
rsync -LtgoDv --partial --no-perms --progress ../../index.html ../../index.ja.html ../../index.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

exit 0;

