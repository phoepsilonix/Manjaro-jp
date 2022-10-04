#!/bin/sh

curdir=${PWD##*/}
repodir=~/gitlab/Manjaro-jp/artifacts/manjaro-jp/

find . -name "linux[0-9]*-*.zst" -o -name "linux[0-9]*-*.zst.sig" -type f | xargs -I{} mv {} $repodir

exit 0
