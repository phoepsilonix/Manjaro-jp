#!/bin/sh

rm ~/www/artifacts/* -rf
mkdir -p ~/www/artifacts/
cp -al artifacts/* ~/www/artifacts
#for f in $(find artifacts/ -type d);do mkdir -p ~/www/$f; files=$(ls -Fd $f/* | grep -v "/$"| sed 's/[*@]$//');ln $files ~/www/$f/ ;done

