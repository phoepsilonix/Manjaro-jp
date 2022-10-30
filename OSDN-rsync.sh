#!/bin/sh
#set -eux

repo_dir=./artifacts/

# USBへバックアップ
echo "usb"
usb=/run/media/phoepsilonix/Ventoy
#rsync -aLv $repo_dir/ $usb/artifacts/

# OSDNへアップデート
echo "OSDN"
#touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
eval `keychain --agents ssh --eval id_ed25519`
rsync -ptgoLvP --no-perms --exclude=*.iso --exclude=\.* --exclude=*.torrent $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# torrentファイルはisoのあとにアップロードさせる。
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -ptgoLvP --size-only --no-perms --exclude=\.* $repo_dir/*.iso phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -ptgoLvP --no-perms --exclude=\.* $repo_dir/*.torrent phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# 残りをまともて高速チェックでアップロード
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -avLP --no-perms --size-only --exclude=\.* $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -ptgoLvP --size-only $repo_dir/ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -ptgoLvPz --no-perms $repo_dir/README.md $repo_dir/README.en.md $repo_dir/README.ja.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -ptgoLvPz --no-perms index.html index.ja.html index.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

# manjaro-jpはrepo-update.shで更新する。

exit 0;

