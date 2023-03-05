#!/bin/sh

base=$(grep "_basekernel=" PKGBUILD)
ver1=$(grep "pkgver=" PKGBUILD)
ver2=$(grep "pkgrel=" PKGBUILD)
ver=${ver1##pkgver=}-${ver2##pkgrel=}-MANJARO
base=${base##_basekernel=}
dir=src/linux-${base}/certs/

for f in $dir/signing_key.*
do
        f2=${f##*/}
        #echo $f ${f%\.*}-$ver.${f##*\.}
        echo cp $f ${f2%\.*}-$ver.${f2##*\.}
        cp $f ${f2%\.*}-$ver.${f2##*\.}
        echo sudo cp -a $f /var/lib/dkms/${f2%\.*}-$ver.${f2##*\.}
        sudo cp -a $f /var/lib/dkms/${f2%\.*}-$ver.${f2##*\.}
done

