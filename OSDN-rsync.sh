#!/bin/sh
#set -eux

repo_dir=./artifacts/

# USBへバックアップ
echo "usb"
usb=/run/media/phoepsilonix/Ventoy
#rsync -aLv $repo_dir/ $usb/artifacts/

set -u     # Stop if an unbound variable is referenced
#set -e     # Stop on first error

export HISTIGNORE="expect*";
password=$(cat ~/.ssh/pass)
expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

# OSDNへアップデート
echo "OSDN"
#主にmanjaro-jp以下のファイルをアップロード
rsync -ptgoLvP --no-perms --exclude=*.iso --exclude=\.* --exclude=*\.torrent $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# isoファイルをアップロード
# torrentファイルはisoのあとにアップロードさせる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -ptgoLvP --size-only --no-perms --exclude=\.* --exclude=*\.torrent $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -ptgoLvP --no-perms --exclude=\.* $repo_dir/*.torrent phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# 残りをまとめて高速チェックでアップロード
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avLP --no-perms --size-only --exclude=\.* --delete $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -ptgoLvPz --no-perms $repo_dir/README.md $repo_dir/README.en.md $repo_dir/README.ja.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -ptgoLvPz --no-perms index.html index.ja.html index.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

# manjaro-jpはrepo-update.shで更新する。

exit 0;

