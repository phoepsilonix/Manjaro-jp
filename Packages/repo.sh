#!/bin/sh

curdir=${PWD##*/}
repodir=~/gitlab/Manjaro-jp/artifacts/manjaro-jp/

find . -name "linux[0-9]*-*.zst" -o -name "linux[0-9]*-*.zst.sig" -type f | xargs -I{} mv {} $repodir
#find . -type f \( -name "*.gz*" -o -name "*.xz" \) -exec rm {} +
#gpg -dq ~/.ssh/pass.gpg | sudo -S pacman -Rns zfs-dkms zfs-utils --noconfirm

gpg -dq ~/.ssh/pass.gpg | sudo -S pacman -Rns zfs-utils --noconfirm

exit 0
