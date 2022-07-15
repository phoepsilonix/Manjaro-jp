#!/bin/sh

sudo pacman -Sy nginx-quic nginx-mod-brotli git-lfs base-devel neovim clang lld llvm aria2 manjaro-tools-iso-git rsync sox --needed

mkdir -p ~/gitlab
cd ~/gitlab
[[ ! -e Manjaro-jp ]] && git clone git@gitlab.com:phoepsilonix/Manjaro-jp.git
cd ~/gitlab/Manjaro-jp

sudo cp makepkg.conf /etc/
cp makepkg.conf ~/.makepkg.conf

usb=/run/media/phoepsilonix/Ventoy
[[ -e $usb/ ]] && rsync -av $usb/artifacts/ ./artifacts/

sudo cp nginx.conf /etc/nginx/
sync
sudo systemctl enable nginx
sudo systemctl start nginx
cp iso-profiles.conf ~/.config/manjaro-tools/
#dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein
rm installer.sh

# end
exit 0

