#!/bin/sh

repo_dir=artifacts

# SourceForge
echo "SourceForge"
# iso
rsync -LtgoDvnd --partial --progress --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# torrentファイルよりも先にisoをアップロードする。
rsync -LtgoDv --partial --progress $repo_dir/*.iso phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# artifactsフォルダのみ。SFはファイル名にコロンを許容しないので、manjaro-jpはバックアップしない。
rsync -LtgoDvd --partial --progress --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

rsync -aLv --partial --progress README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLv --partial --progress ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

