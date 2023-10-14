#/usr/bin/env sh

cd artifacts
#browser=firefox
browser=floorp

for f in manjaro-*.iso ;
do
        if [[ $f =~ .*-jp* ]]; then
                continue;
        else
                f2=$(echo $f|sed s/jp-jp-jp-/jp-/);
                if [[ ! $f =~ .*-architect-.* ]]; then
                    [[ "$browser" != "" ]] && f2=$(echo $f2|sed s/-${browser}-${browser}-${browser}.iso/-${browser}.iso/);
                fi
        fi
        echo $f $f2;
        #mv $f $f2;
done

cd ..
