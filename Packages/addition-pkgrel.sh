
for m in $(cat ../extramodules.txt)
do
    pkgrel=$(grep -E pkgrel=.* $m/PKGBUILD)
    pkgrel=$((pkgrel+1))
    echo $m $pkgrel
    sed "s|pkgrel=.*|pkgrel=${pkgrel}|" $m/PKGBUILD -i
done
