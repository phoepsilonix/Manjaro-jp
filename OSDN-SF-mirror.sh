#!/bin/bash
#set -eux

repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/

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
        send "$password\r"
  }
  expect eof
EOF

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

# OSDNへアップデート
echo "OSDN"
eval `keychain --agents ssh --eval id_ed25519`
rsync -avPL --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# SourceForge
echo "SourceForge"
# iso
eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvPn --size-only --delete --exclude=manjaro-jp/* ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLvP --size-only --delete --exclude=manjaro-jp/* ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

exit 0;

