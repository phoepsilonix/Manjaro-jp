#!/bin/sh

repo_dir=artifacts

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
eval `keychain --agents ssh --eval id_ed25519`
# SourceForge
echo "SourceForge"
# iso
rsync -LtgoDvndP --exclude=\.* --exclude= $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
# torrentファイルよりも先にisoをアップロードする。
eval `keychain --agents ssh --eval id_ed25519`
rsync -LtgoDvP --exclude=\.* --exclude=*\.torrent $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
eval `keychain --agents ssh --eval id_ed25519`
rsync -LtgoDvdP --exclude=*.iso --exclude=\.* $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvPz README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvPz ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

