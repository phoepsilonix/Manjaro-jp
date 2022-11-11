#!/bin/bash
#set -eux

repo_dir=./artifacts/
cd $repo_dir;

mkdir -p $repo_dir/manjaro-jp/

export HISTIGNORE="expect*";
password=$(cat ~/.ssh/pass)
expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        send "$password\r"
  }
  expect eof
EOF

# OSDNへアップデート
echo "OSDN"
eval `keychain --agents ssh --eval id_ed25519`
rsync -rLtgoDv --checksum --no-perms --progress ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/ || { echo "OSDN rsync error" ; exit 1 ; }

# SourceForge
echo "SourceForge"
# iso
eval `keychain --agents ssh --eval id_ed25519`
rsync -aLvn --checksum ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLv --checksum --progress ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

exit 0;

