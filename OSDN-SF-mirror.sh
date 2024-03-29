#!/bin/bash
#set -eux

. keychain.sh

./md2html.sh
repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

# SourceForge
echo "SourceForge"

eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvP --size-only --delete --exclude=manjaro-jp/* --exclude=*\.html --exclude=*\.css ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLvPc --delete --exclude=manjaro-jp/* --exclude=*\.html --exclude=*\.css ./*.sig phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -avPLz ./*.css ./*.js ./*.md ./*.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/
#sourceforge web
#X:symlink rsync -L
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --delete manjaro-jp/ phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/manjaro-jp/


# OSDNへアップデート
echo "OSDN"
eval `keychain --agents ssh --eval id_ed25519`
rsync -avPL --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -avPLc --no-perms --delete ./*.sig phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -avPLz --no-perms ./*.css ./*.js ./*.md ./*.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs
#OSDN web
#OK:symlink
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avP --delete manjaro-jp/ phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs/manjaro-jp/



exit 0;

