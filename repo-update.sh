#!/bin/sh
#set -eux

export LC_ALL=C.UTF-8
export LANG=C.utf8
#export TAR_READER_OPTIONS="--option=pathnameencoding=UTF-8 --options=!pax_global_header"
#export TAR_WRITER_OPTIONS="--format=ustar --options=pax_restricted"
#export TAR_READER_OPTIONS="--option=pathnameencoding=UTF-8"
#export TAR_WRITER_OPTIONS="--option=pathnameencoding=UTF-8"

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
#rm $repo.db.* $repo.files.*

# repo-add
#-n 新しいパッケージのみ追加
#-R 古いパッケージを削除
#nvidia unstable stable
SRC=rsync://ftp.tsukuba.wide.ad.jp/manjaro/
SRC=rsync://ftp.riken.jp/manjaro
SRC=/var/www/manjaro/
#rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/unstable/extra/x86_64/{libxnvctrl,nvidia-*{utils,dkms,settings},virtualbox-host-dkms,zfs-utils,zfs-dkms}* ./
#rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/unstable/multilib/x86_64/lib32-nvidia-*utils* ./
#rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/stable/extra/x86_64/{libxnvctrl,nvidia-*{utils,dkms,settings},virtualbox-host-dkms,zfs-utils,zfs-dkms}* ./
#rsync -rtLvH --safe-links --delete-after --delay-updates $SRC/stable/multilib/x86_64/lib32-nvidia-*utils* ./

# kernel module nvidia関連の新しいものをふくめ、複数バージョンをレポジトリに加えるため
# 6.17から公式カーネルに切り替えるので、不要。コメントアウト
#rsync -rtLvH --safe-links --delete-after --delay-updates --include="libxnvctrl*x86_64*" --include="*nvidia-*utils*x86_64*" --include="egl-gbm-*x86_64*" --include="egl-wayland*x86_64*" --include="egl-x11*x86_64*" --include="*nvidia-*dkms*x86_64*" --include "*nvidia-*settings*x86_64*" --include="virtualbox-host-dkms*x86_64*" --include="zfs-utils*x86_64*" --include="zfs-dkms*x86_64*" --include="python-legacy-cgi*" --exclude="*" $SRC/pool/sync/ $SRC/pool/overlay/ ./

#rsync -rtLvH --safe-links --delete-after --delay-updates --include="libxml2*x86_64*" --include="libarchive*x86_64*" --include="libxnvctrl*x86_64*" --include="*nvidia-*utils*x86_64*" --include="egl-gbm-*x86_64*" --include="egl-wayland*x86_64*" --include="egl-x11*x86_64*" --include="*nvidia-*dkms*x86_64*" --include "*nvidia-*settings*x86_64*" --include="virtualbox-host-dkms*x86_64*" --include="zfs-utils*x86_64*" --include="zfs-dkms*x86_64*" --include="python-legacy-cgi*" --exclude="*" $SRC/pool/sync/ $SRC/pool/overlay/ ./
#cp -al ../../virtualbox-host-dkms*.pkg.tar.* ./
#for f in virtualbox-host-dkms-*.pkg.tar.{zst,xz}
#do
#	[[ ! -f "$f.sig" ]] && { echo "gpg sign: $f" ; gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback --default-key $repo_key -v -b $f; }
#done
#for f in virtualbox-host-dkms*.pkg.tar.*.sig
#do
#	echo "$f ${f%.*} gpg verify"
#	gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "pkg verify error" ; exit 1; }
#done
sync

#nvidia以外のパッケージの登録。古いものを削除。
# バージョンでsortしておく。repo-addは、あとから追加されたものが優先されるため。
pkgfiles=$(ls -v *.pkg.tar.zst *.pkg.tar.xz)
echo $pkgfiles
repo-add $repo.db.tar.xz -v --include-sigs --sign --key $repo_key ${pkgfiles}


# kernel module nvidia関連の新しいものをふくめ、複数バージョンをレポジトリに加えるため
# 6.17から公式カーネルに切り替えるので、不要。コメントアウト
#pkgfiles=$(ls -v --ignore={manjaro-jp.,libxml2-,libarchive-,nvidia-,lib32-nvidia,libxnvctrl,virtualbox-host-dkms,zfs-utils,zfs-dkms,egl-gbm-,egl-wayland-,egl-x11-,python-legacy-cgi-}* --ignore=*.sig --ignore=*.html)
#pkgfiles=$(ls -v --ignore={manjaro-jp.,nvidia-,lib32-nvidia,libxnvctrl,virtualbox-host-dkms,zfs-utils,zfs-dkms,egl-gbm-,egl-wayland-,egl-x11-,python-legacy-cgi-}* --ignore=*.sig --ignore=*.html)
#echo $pkgfiles
#repo-add $repo.db.tar.xz -R -v --include-sigs --sign --key $repo_key ${pkgfiles}

#repo-add $repo.db.tar.xz -v --include-sigs --sign --key $repo_key ${pkgfiles}
#nvidia関連のパッケージの追加
# nvidia stable unstable ともに残す
#pkgfiles=$(ls -v {nvidia,lib32-nvidia,libxnvctrl,virtualbox-host-dkms,zfs-utils,zfs-dkms,egl-gbm-,egl-wayland-,egl-x11-}*.pkg.tar.* |grep -Ev ".*\.sig$")

# kernel module nvidia関連の新しいものをふくめ、複数バージョンをレポジトリに加えるため
# 6.17から公式カーネルに切り替えるので、不要。コメントアウト
#pkgfiles=$(ls -v *.pkg.tar.* |grep -Ev ".*\.sig$")
#echo $pkgfiles
#echo $pkgfiles|grep virtualbox
#repo-add $repo.db.tar.xz -v --include-sigs --sign --key $repo_key ${pkgfiles}

#repo-add $repo.db.tar.xz -v --include-sigs --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -n --sign --key $repo_key ${pkgfiles}
#repo-add $repo.db.tar.xz -R --sign --key $repo_key ./*.zst 
#repo-add $repo.db.tar.xz -n -R --sign --key $repo_key ./*.zst

# レポジトリデータベースの署名を削除する
# pamacとの整合性のため、パッケージのみ署名を残す
for f in *.{db,files}.tar.xz.sig
do
	#echo "${f%.*} gpg verify"
	#gpg --passphrase-file $gpg_pass --batch --pinentry-mode=loopback -v --default-key $repo_key --verify $f ${f%.*} || { echo "repo db verify error" ; exit 1; }
        rm $f
done
rm manjaro-jp.db.sig manjaro-jp.files.sig

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
  spawn keychain --eval id_ed25519_3 id_ed25519
  expect "* passphrase *:" {
        stty -echo
        send "$password\r"
        stty echo
  }
  expect eof
EOF

rm index.html
rm ~/www/artifacts/* -rf

#(cd ../.. && for f in $(find artifacts/ -type d);do mkdir -p ~/www/$f; files=$(ls -Fd $f/* | grep -v "/$"| sed 's/[*@]$//');ln $files ~/www/$f/ ;done)
mkdir -p ~/www/artifacts
(cd ../.. && cp -al artifacts/* ~/www/artifacts)
# h2oサーバーの生成するindex.htmlを取得。sf,osdnへアップロードするため。
rm ~/www/artifacts/manjaro-jp/index.html
aria2c -c https://manjaro-jp.phoepsilonix.love/manjaro-jp/
ln -f index.html ~/www/artifacts/manjaro-jp/

# Backup(localhost)
gpg -dq $gpg_pass.gpg | sudo -S pwd > /dev/null
#sudo rsync -avPHL --progress --delete --delete-after ./ /root/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }
#rsync -avPHL --progress --delete --delete-after ./ ~/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }
rm -rf ~/manjaro-jp/
mkdir -p ~/manjaro-jp/ && cp -al ./* ~/manjaro-jp/

# usb
#sudo rsync -avP --progress  ./ $usb/artifacts/manjaro-jp/ || { echo "rsync to local backup error"; exit 1; }

# OSDNへアップデート
#eval `keychain --eval id_ed25519 2>/dev/null`
#rsync -avPLc --no-perms ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#eval `keychain --eval id_ed25519 2>/dev/null`
#rsync -avPL --size-only --no-perms ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#rsync -avPL --size-only --no-perms --delete --exclude=\.* ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }

#OSDN 
#OK:symlink
#eval `keychain --eval id_ed25519 2>/dev/null`
#rsync -avPLc --no-perms ./manjaro-jp.* phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -avPL --size-only --no-perms ./*.zst phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#rsync -avPL --size-only --no-perms --delete --exclude=\.* ./ phoepsilonix@storage.osdn.net:/storage/groups/m/ma/manjaro-jp/manjaro-jp/ || { echo "rsync error"; exit 1; }
#osdn web
#eval `keychain --eval id_ed25519 id_ed25519_3 2>/dev/null`
#rsync -avP --delete --delete-after ./ phoepsilonix@shell.osdn.net:/home/groups/m/ma/manjaro-jp/htdocs/manjaro-jp/

#sourceforge 
#X:symlink rsync -L
eval `keychain --eval id_ed25519_3 id_ed25519 2>/dev/null`
rsync -avPL --delete --delete-after ./ phoepsilonix@web.sourceforge.net:/home/project-web/manjaro-jp/htdocs/manjaro-jp/

exit 0;

