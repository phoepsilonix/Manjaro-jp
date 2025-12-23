#!/bin/bash
#set -eux

. keychain.sh

#./md2html.sh
#repo_dir=~/www/artifacts/
repo_dir=~/gitlab/Manjaro-jp/artifacts/
cd $repo_dir;

#mkdir -p $repo_dir/manjaro-jp/

###### このスクリプト内で、有効化させる。
eval `keychain --eval id_ed25519_3 2>/dev/null`

# SourceForge
echo "SourceForge"

eval `keychain --eval id_ed25519_3`
rsync -aLvPc --delete --delete-after --exclude=*cinnamon* --exclude=*gnome* --exclude=*kde* --exclude=*xfce* --exclude=manjaro-jp/* --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./*.sig ./*.md -e "ssh -i ~/.ssh/id_ed25519_3" phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ #|| { echo "SF rsync error" ; exit 1 ; }
eval `keychain --eval id_ed25519_3`
rsync -aLvP --size-only --delete --delete-after --exclude=*cinnamon* --exclude=*gnome* --exclude=*kde* --exclude=*xfce* --exclude=manjaro-jp/* --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ -e "ssh -i ~/.ssh/id_ed25519_3" phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
#sourceforge web
#X:symlink rsync -L
eval `keychain --eval id_ed25519_3`
rsync -avPL ./img ./*.css ./*.js ./*.md ./*.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/ -e "ssh -i ~/.ssh/id_ed25519_3"
eval `keychain --eval id_ed25519_3 2>/dev/null`
rsync -avPL --delete --delete-after manjaro-jp/ phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/manjaro-jp/ -e "ssh -i ~/.ssh/id_ed25519_3"


#echo "OSDN"
# OSDNへアップデート
#eval `keychain --eval id_ed25519`
#rsync -avPL --delete-after --delay-updates --safe-links --size-only --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -avPL --delete-after --delay-updates --safe-links --size-only --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -avPLc --delete-after --delay-updates --safe-links --no-perms --delete --exclude={*\.html,*\.css,*\.ts,*\.js,*\.ts,*\.sh} ./*.sig ./*.md phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

#OSDN web
#OK:symlink
#eval `keychain --eval id_ed25519`
#rsync -avPL --no-perms ./img ./*.css ./*.js ./*.md ./*.html phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs
#eval `keychain --eval id_ed25519 2>/dev/null`
#rsync -avP --delete-after --delete manjaro-jp/ phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs/manjaro-jp/

#rsync -avPL --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

exit 0;

