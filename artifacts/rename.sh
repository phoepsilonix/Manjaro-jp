#/usr/bin/env sh

#cd artifacts;
browser=firefox

for f in manjaro-*.iso ;
do
        if [[ "$f" == *-jp* ]]; then
                continue;
        else
                f2=$(echo $f|sed s/^manjaro/manjaro-jp/);
                f2=$(echo $f2|sed s/\.iso/-${browser}.iso/);
        fi
        echo $f $f2;
        mv $f $f2;
done

exit 0;
