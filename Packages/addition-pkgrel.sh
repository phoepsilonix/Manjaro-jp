WD=$(basename $PWD)
WD=${WD/*-/}
VER=${WD/./}
for m in $(cat extramodules.txt)
do
    f=$(ls ~/gitlab/Manjaro-jp/artifacts/manjaro-jp/linux$VER-$m*.zst||true);
    pkgrel=$(echo $f|sed "s|.*-\(.*\)-x86_64.*|\1|")
    [[ -z $pkgrel ]] && pkgrel=0
    pkgrel=$(echo $pkgrel + 1 | bc | xargs printf "%.0f\n")
    echo $m $pkgrel
    sed "s|pkgrel=.*|pkgrel=${pkgrel}|" $m/PKGBUILD -i
done
