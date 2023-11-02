#!/bin/sh
#set -eux

repo_dir=./artifacts/manjaro-jp
repo_key=$(cat ~/.gnupg/sign.txt)
usb=/run/media/phoepsilonix/Ventoy
repo=manjaro-jp
gpg_pass=~/.ssh/gpg-passphrase
ssh_pass=~/.ssh/ssh-passphrase.gpg

cd $repo_dir; 


gpg -dq $gpg_pass.gpg | sudo -S pwd > /dev/null
# usb
# 古いパッケージをバックアップ
#sudo rsync -avP --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# 署名がないパッケージに署名をする
for f in *.pkg.tar.{xz,zst}
do
	[[ ! -f "$f.sig" ]] && { echo "gpg sign: $f" ; gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
done

# パッケージの署名の検証
for f in *.pkg.tar.*.sig
do
	echo "$f ${f%.*} gpg verify"
	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
done

# レポジトリデータベースの更新
rm $repo.db.* $repo.files.*

# repo-add
#-n 新しいパッケージのみ追加
#-R 古いパッケージを削除
#nvidia unstable stable
SRC=rsync://ftp.tsukuba.wide.ad.jp/manjaro/
SRC=/var/www/manjaro/
rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/unstable/extra/x86_64/{libxnvctrl,nvidia-*{utils,dkms,settings},virtualbox-host-dkms,zfs-utils,zfs-dkms}* ./
rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/unstable/multilib/x86_64/lib32-nvidia-*utils* ./
rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/stable/extra/x86_64/{libxnvctrl,nvidia-*{utils,dkms,settings},virtualbox-host-dkms,zfs-utils,zfs-dkms}* ./
rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/stable/multilib/x86_64/lib32-nvidia-*utils* ./


#nvidia以外のパッケージの登録。古いものを削除。
# バージョンでsortしておく。repo-addは、あとから追加されたものが優先されるため。
pkgfiles=$(ls -v --ignore={manjaro-jp.,nvidia-,lib32-nvidia,libxnvctrl,virtualbox-host-dkms,zfs-utils,zfs-dkms}* --ignore=*.sig)
echo $pkgfiles
LOCALE=C LANG=C LC_ALL=C repo-add $repo.db.tar.xz -R --sign --key $repo_key ${pkgfiles}
#nvidia関連のパッケージの追加
# nvidia stable unstable ともに残す
pkgfiles=$(ls -v {nvidia,lib32-nvidia,libxnvctrl,virtualbox-host-dkms,zfs-utils,zfs-dkms}*.zst)
echo $pkgfiles
LOCALE=C LANG=C LC_ALL=C repo-add $repo.db.tar.xz --sign --key $repo_key ${pkgfiles}

#repo-add $repo.db.tar.xz -n --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -R --sign --key $repo_key ./*.zst 
#repo-add $repo.db.tar.xz -n -R --sign --key $repo_key ./*.zst

# レポジトリデータベースの署名の検証
for f in *.{db,files}.tar.xz.sig
do
	echo "${f%.*} gpg verify"
	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "repo db verify error" ; exit 1; }
done

# パッケージの署名の検証
for f in *.pkg.tar.*.sig
do
	echo "$f ${f%.*} gpg verify"
	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
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
  spawn keychain --agents ssh --eval id_ed25519_3 id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF

# localhost
gpg -dq $gpg_pass.gpg | sudo -S pwd > /dev/null
sudo rsync -avP --progress --delete --delete-after ./ /root/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# h2oサーバーの生成するindex.htmlを取得。sf,osdnへアップロードするため。
aria2c -c https://manjaro-jp.phoepsilonix.love/manjaro-jp/
# usb
#sudo rsync -avP --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# OSDNへアップデート
#eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
#rsync -avPLc --no-perms ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
#rsync -avPL --size-only --no-perms ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#rsync -avPL --size-only --no-perms --delete --exclude=\.* ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#OSDN 
#OK:symlink
#eval `keychain --agents ssh --eval id_ed25519 2>/dev/null`
#rsync -avPLc --no-perms ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -avPL --size-only --no-perms ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -avPL --size-only --no-perms --delete --exclude=\.* ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#osdn web
eval `keychain --agents ssh --eval id_ed25519 id_ed25519_3 2>/dev/null`
rsync -avP --delete --delete-after ./ phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs/manjaro-jp/

#sourceforge 
#X:symlink rsync -L
eval `keychain --agents ssh --eval id_ed25519_3 id_ed25519 2>/dev/null`
rsync -avPL --delete --delete-after ./ phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/manjaro-jp/

exit 0;

