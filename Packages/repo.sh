#!/bin/sh

curdir=${PWD##*/}
repodir=~/gitlab/Manjaro-jp/artifacts/manjaro-jp/

find . -name "linux518-*.zst" -o -name "linux518-*.zst.sig" -type f | xargs -I{} mv {} $repodir

exit 0
