
for m in $(cat extramodules.txt)
do
    f=$(ls ~/gitlab/Manjaro-jp/artifacts/manjaro-jp/linux67-$m*.zst);
    pkgrel=$(echo $f|sed "s|.*-\(.*\)-x86_64.*|\1|")
    pkgrel=$((pkgrel+1))
    echo $m $pkgrel
    sed "s|pkgrel=.*|pkgrel=${pkgrel}|" $m/PKGBUILD -i
done
