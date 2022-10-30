#!/bin/sh

repo_dir=artifacts

# SourceForge
echo "SourceForge"
# iso
eval `keychain --agents ssh --eval id_ed25519`
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -LtgoDvndP --exclude=\.* $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# torrentファイルよりも先にisoをアップロードする。
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -LtgoDvP --exclude=\.* $repo_dir/*.iso phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }


# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -LtgoDvdP --exclude=*.iso --exclude=\.* $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -aLvPz README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
touch INFO.sig && rm -f INFO.sig && gpg --passphrase-file ~/.ssh/pass --batch --pinentry-mode=loopback -b INFO
rsync -aLvPz ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

