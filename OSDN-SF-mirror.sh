#!/bin/bash
#set -eux

. keychain.sh

./md2html.sh
repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

# OSDNへアップデート
echo "OSDN"
eval `keychain --agents ssh --eval id_ed25519`
rsync -avPL --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -avPLz --no-perms ./*.css ./*.js index.html index.ja.html index.en.html README.ja.html README.en.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs

# SourceForge
echo "SourceForge"
# iso
eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvPn --size-only --delete --exclude=manjaro-jp/* --exclude=*\.html --exclude=*\.css ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLvP --size-only --delete --exclude=manjaro-jp/* --exclude=*\.html --exclude=*\.css ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -avPLz ./*.css ./*.js ./index.html ./index.en.html ./index.ja.html ./README.ja.html ./README.en.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/


exit 0;

