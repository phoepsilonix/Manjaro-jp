#!/bin/sh

repo_dir=artifacts

# SourceForge
echo "SourceForge"
# iso
rsync -aLvn --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

# torrentファイルよりも先にisoをアップロードする。
rsync -aLv --progress $repo_dir/*.iso phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLv --progress --delete $repo_dir/ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }

rsync -aLv --progress README.md README.ja.md README.en.md phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/ || { echo "SF rsync error" ; exit 1 ; }
rsync -aLv --progress ./index.html ./index.en.html ./index.ja.html phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/

exit 0;

