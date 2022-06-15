#!/bin/sh
#set -eux

repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/
# OSDNへアップデート
echo "OSDN"
rsync -rLtgoDv --checksum --no-perms --progress ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }
#rsync -rLtgoDv --size-only --no-perms --progress ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# SourceForge
echo "SourceForge"
# iso
rsync -aLvn --checksum ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLv --checksum --progress ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

exit 0;

