#!/bin/bash

ORIGINAL_REPO=$(grep "^source" PKGBUILD |grep "git+https"|sed -e "s|.*com/\(.*\)\#.*|\1|" -e "s|.git$||")
LATEST_COMMIT=$(curl -s https://api.github.com/repos/$ORIGINAL_REPO/commits/gnome-46|jq -r ".sha")
LATEST_COMMIT=$(curl -s https://api.github.com/repos/$ORIGINAL_REPO/commits/master|jq -r ".sha")
echo $ORIGINAL_REPO
echo "Latest :" $LATEST_COMMIT

# PKGBUILD
COMMIT=$(grep "^_commit" PKGBUILD|cut -f2 -d"=")
echo "Current:" $COMMIT

if [[ "$COMMIT" != "$LATEST_COMMIT" ]]; then
    echo "change detected."
    #git checkout master
    sed -i 's|^_commit=.*$|_commit='"${LATEST_COMMIT}"'|' PKGBUILD
    updpkgsums
    mksrcinfo
    git diff -- .
    git commit -a -m "Update: _commit=${LATEST_COMMIT}"
    #git push
    #git checkout makepkg
else
    echo "No change detected."
fi
