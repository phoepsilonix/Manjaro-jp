#!/bin/sh
#set -eux

repo_dir=./artifacts/manjaro-jp
repo_key=$(cat ~/.gnupg/sign.txt)
usb=/run/media/phoepsilonix/Ventoy
repo=manjaro-jp
gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg

cd $repo_dir; 

# usb
# 古いパッケージをバックアップ
sudo rsync -avP --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# 署名がないパッケージに署名をする
for f in *.zst *.xz
do
	[[ ! -f "$f.sig" ]] && { echo "gpg sign: $f" ; gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
done

# パッケージの署名の検証
for f in *.zst.sig *.xz.sig
do
	echo "$f ${f%.*} gpg verify"
	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
done

# レポジトリデータベースの更新
rm $repo.db.* $repo.files.*

# バージョンでsortしておく。repo-addは、あとから追加されたものが優先されるため。
pkgfiles=$(ls -v ./*.zst ./*.xz)

# repo-add
#-n 新しいパッケージのみ追加
#-R 古いパッケージを削除
LOCALE=C LANG=C LC_ALL=C repo-add $repo.db.tar.xz -n -R --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -n --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -R --sign --key $repo_key ./*.zst 
#repo-add $repo.db.tar.xz -n -R --sign --key $repo_key ./*.zst

# レポジトリデータベースの署名の検証
for f in *.{db,files}.tar.xz.sig
do
	echo "${f%.*} gpg verify"
	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "repo db verify error" ; exit 1; }
done

###### expectによる、履歴を残さない
export HISTIGNORE="expect*";

###### スクリプト終了時には、keychainをクリアして、ssh-agentを停止する。
trap "
keychain --clear
keychain -k mine
" EXIT

###### sshのパスフレーズを復号化する
password=$(gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -dq $ssh_pass)

###### expectでパスフレーズ入力を自動化
expect << EOF
  spawn keychain --agents ssh --eval id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF

# localhost
cat $gpg_pass |sudo -S ls > /dev/null
sudo rsync -avP --progress --delete ./ /root/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# usb
sudo rsync -avP --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# OSDNへアップデート
eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --no-perms ./*.sig ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --size-only --no-perms ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
rsync -avPL --size-only --no-perms --delete --exclude=\.* ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

exit 0;

