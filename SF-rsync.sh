#!/bin/bash

repo_dir=artifacts
gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg

. keychain.sh

# SourceForge
echo "SourceForge"
# iso
rsync -avPL --exclude=\.* --exclude=manjaro-jp/* --exclude= $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
# torrentファイルよりも先にisoをアップロードする。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --exclude=\.* --exclude=manjaro-jp/* --exclude=*\.torrent $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --exclude=manjaro-jp/* --exclude=*.iso --exclude=\.* $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPLz README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
cd $repo_dir
rsync -avPLz ./*.css ./*.js ./index.html ./index.en.html ./index.ja.html ./README.ja.html ./README.en.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

