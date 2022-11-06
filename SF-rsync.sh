#!/bin/sh

repo_dir=artifacts
gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg


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

# SourceForge
echo "SourceForge"
# iso
rsync -LtgoDvndP --exclude=\.* --exclude= $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
# torrentファイルよりも先にisoをアップロードする。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -LtgoDvP --exclude=\.* --exclude=*\.torrent $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -LtgoDvdP --exclude=*.iso --exclude=\.* $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -aLvPz README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -aLvPz ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

