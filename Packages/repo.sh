#!/bin/sh

curdir=${PWD##*/}
repodir=~/gitlab/Manjaro-jp/artifacts/manjaro-jp/

find . -name "linux[0-9]*-*.zst" -o -name "linux[0-9]*-*.zst.sig" -type f | xargs -I{} mv {} $repodir
find . -type f \( -name "*.run" -o -name "*.gz*" -o -name "*.xz" -o -name "*.zip" \) -exec ls {} +

exit 0
