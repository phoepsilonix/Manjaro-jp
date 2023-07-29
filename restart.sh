#!/bin/sh

gpg -dq ~/.ssh/pass.gpg|sudo -S pacman -Sy git-lfs git-delta base-devel neovim clang lld llvm aria2 manjaro-tools-iso-git rsync sox paru fuse-overlayfs keychain expect h2o-git ruby-rbenv ruby-bundler rustup --needed
paru -Sy rbenv ruby-build --needed --noconfirm
rbenv install 3.2.2
rbenv install mruby
rbenv shell 3.2.2
. ~/.bashrc
rbenv exec gem install bundler
rbenv exec gem install rake
rbenv exec gem update
rustup install stable
rustup component add rust-src
#cargo install bindgen

mkdir -p ~/gitlab
cd ~/gitlab
[[ ! -e Manjaro-jp ]] && git clone git@gitlab.com:phoepsilonix/Manjaro-jp.git
cd ~/gitlab/Manjaro-jp
git submodule update --init --recursive --remote

sudo cp makepkg.conf /etc/
cp makepkg.conf ~/.makepkg.conf

usb=/run/media/phoepsilonix/Ventoy
[[ -e $usb/ ]] && rsync -avp $usb/artifacts/ ./artifacts/

#sudo cp nginx.conf /etc/nginx/
#sync
#sudo systemctl enable nginx
#sudo systemctl start nginx
cp iso-profiles.conf ~/.config/manjaro-tools/
#dein.vim
#curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
#sh ./installer.sh ~/.cache/dein
#rm installer.sh

# iso-profiles buildiso
mkdir -p ~/work
cd ~/work
git clone --depth 1 --no-single-branch https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git iso-profiles
#git clone ssh://git@gitlab.manjaro.org:22277/packages/core/linux519.git
#git clone ssh://git@gitlab.manjaro.org:22277/packages/core/linux515.git

# end
exit 0

