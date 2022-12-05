#!/bin/sh

sudo pacman -Sy nginx-quic nginx-quic-mod-brotli git-lfs base-devel neovim clang lld llvm aria2 manjaro-tools-iso-git rsync sox --needed
sudo pacman -Sy --needed paru fuse-overlayfs keychain expect 

mkdir -p ~/gitlab
cd ~/gitlab
[[ ! -e Manjaro-jp ]] && git clone git@gitlab.com:phoepsilonix/Manjaro-jp.git
cd ~/gitlab/Manjaro-jp
git submodule --init

sudo cp makepkg.conf /etc/
cp makepkg.conf ~/.makepkg.conf

usb=/run/media/phoepsilonix/Ventoy
[[ -e $usb/ ]] && rsync -avp $usb/artifacts/ ./artifacts/

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

# iso-profiles buildiso
mkdir -p ~/work
cd ~/work
git clone https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git iso-profiles
git clone ssh://git@gitlab.manjaro.org:22277/packages/core/linux519.git
git clone ssh://git@gitlab.manjaro.org:22277/packages/core/linux515.git

# end
exit 0

