#!/bin/sh
#set -eux

repo_dir=./artifacts/
gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg

# USBへバックアップ
echo "usb"
usb=/run/media/phoepsilonix/Ventoy
#rsync -aLv $repo_dir/ $usb/artifacts/

set -u     # Stop if an unbound variable is referenced
#set -e     # Stop on first error

###### expectによる、履歴を残さない
export HISTIGNORE="expect*";

###### スクリプト終了時には、keychainをクリアして、ssh-agentを停止する。
trap "
keychain --clear
keychain -k mine
" EXIT

###### sshのパスフレーズを復号化する
password=$(gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -dq $ssh_pass)

###### expectでパスフレーズ入力を自動化
expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

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
rsync -avPLz --no-perms index.html index.ja.html index.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

# manjaro-jpはrepo-update.shで更新する。

exit 0;

