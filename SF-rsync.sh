#!/bin/sh

repo_dir=artifacts

# SourceForge
echo "SourceForge"
# iso
rsync -LtgoDvnPd --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# torrentファイルよりも先にisoをアップロードする。
rsync -LtgoDvP --progress $repo_dir/*.iso phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
rsync -LtgoDvPd --progress --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

rsync -aLvP --progress README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLvP --progress ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

