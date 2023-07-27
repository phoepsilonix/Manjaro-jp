#!/bin/bash
#set -eux

. keychain.sh

#./md2html.sh
repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/

###### このスクリプト内で、有効化させる。
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`

# SourceForge
echo "SourceForge"

eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvPc --delete --exclude=manjaro-jp/* --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./*.sig ./*.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLvP --size-only --delete --exclude=manjaro-jp/* --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -avPLz ./*.css ./*.js ./*.md ./*.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/
#sourceforge web
#X:symlink rsync -L
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --delete manjaro-jp/ phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/manjaro-jp/


echo "OSDN"
# OSDNへアップデート
eval `keychain --agents ssh --eval id_ed25519`
rsync -avPL --delete-after --delay-updates --safe-links --size-only --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -avPL --delete-after --delay-updates --safe-links --size-only --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
rsync -avPLc --delete-after --delay-updates --safe-links --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./*.sig ./*.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

#OSDN web
#OK:symlink
rsync -avPLz --no-perms ./*.css ./*.js ./*.md ./*.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avP --delete manjaro-jp/ phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs/manjaro-jp/

#rsync -avPL --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

exit 0;

