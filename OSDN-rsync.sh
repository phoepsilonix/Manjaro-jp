#!/bin/bash
#set -eux

repo_dir=./artifacts/

. keychain.sh

# USBへバックアップ
echo "usb"
usb=/run/media/phoepsilonix/Ventoy
#rsync -aLv $repo_dir/ $usb/artifacts/

set -u     # Stop if an unbound variable is referenced
#set -e     # Stop on first error

# OSDNへアップデート
echo "OSDN"
#主にmanjaro-jp以下のファイルをアップロード
rsync -avPL --no-perms --exclude=*.iso --exclude=\.* --exclude=*\.torrent $repo_dir/* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# isoファイルをアップロード
# torrentファイルはisoのあとにアップロードさせる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --size-only --no-perms --exclude=\.* --exclude=*\.torrent $repo_dir/* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -ptgoLvP --no-perms --exclude=\.* $repo_dir/*.torrent phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# 残りをまとめて高速チェックでアップロード
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --no-perms --size-only --exclude=\.*  $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPLz --no-perms $repo_dir/README.md $repo_dir/README.en.md $repo_dir/README.ja.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
cd $repo_dir
rsync -avPLz --no-perms ./*.css ./*.js index.html index.ja.html index.en.html README.ja.html README.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

# manjaro-jpはrepo-update.shで更新する。

exit 0;

