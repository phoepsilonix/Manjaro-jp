#!/bin/sh
#set -eux

repo=manjaro-jp
repo_dir=./artifacts/manjaro-jp
repo_key=$(cat ~/.gnupg/sign.txt)
usb=/run/media/phoepsilonix/Ventoy

cd $repo_dir; 

# 署名がないパッケージに署名をする
for f in *.zst 
do
	[[ ! -f "$f.sig" ]] && { echo "gpg sign: $f" ; gpg --default-key $repo_key -v -b $f; }
done

# パッケージの署名の検証
for f in *.zst.sig 
do
	echo "$f ${f%.*} gpg verify"
	gpg -v --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
done

# レポジトリデータベースの更新
#rm $repo.db.* $repo.files.*

# バージョンでsortしておく。repo-addは、あとから追加されたものが優先されるため。
pkgfiles=$(ls -v ./*.zst)

repo-add $repo.db.tar.xz --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -n --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -R --sign --key $repo_key ./*.zst 
#repo-add $repo.db.tar.xz -n -R --sign --key $repo_key ./*.zst

# レポジトリデータベースの署名の検証
for f in *.{db,files}.tar.xz.sig
do
	echo "${f%.*} gpg verify"
	gpg -v --default-key $repo_key --verify $f ${f%.*} || { echo "repo db verify error" ; exit 1; }
done

# localhost
cat ~/.ssh/pass|sudo -S ls
eval `keychain --agents ssh --eval id_ed25519`
sudo rsync -av --progress --delete ./ /root/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# usb
sudo rsync -av --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# OSDNへアップデート
rsync -aLvcP --no-perms --delete ./*.sig ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
rsync -aLvP --size-only --no-perms --delete ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
rsync -aLvP --size-only --no-perms --delete ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -rLtgoDv --no-perms --progress --delete ./*.sig ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -rLtgoDv --size-only --no-perms --progress --delete ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#sourceforge コロンがファイル名に含まれるとエラーになる。
#rsync -aLvn --delete ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/manjaro-jp || { echo "SF rsync error" ; exit 1 ; }
#rsync -aLv -c --progress --delete ./ phoepsilonix@frs.sourceforge.net:/home/pfs/project/manjaro-jp/manjaro-jp || { echo "SF rsync error" ; exit 1 ; }

exit 0;

