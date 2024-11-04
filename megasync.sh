#!/bin/bash
#
src=~/gitlab/Manjaro-jp/artifacts/
mega=~/MEGAsync/

#files=$(rsync -ahP [$KAGOYA4]:gitlab/Manjaro-jp/artifacts/*.iso* artifacts/  -e "ssh -p22022" -n|tail -n +2)

for e in gnome kde xfce cinnamon #architect #mate
do
    if [[ "$e" != "architect" ]] ; then
        sf=$(cd ${src}; ls -1rv *${e}*floorp.iso | head -n 1)
        mf=$(cd ${mega}; ls -1rv *${e}*floorp.iso | head -n 1)
    else
        sf=$(cd ${src}; ls -1rv *${e}*.iso | head -n 1)
        mf=$(cd ${mega}; ls -1rv *${e}*.iso | head -n 1)
    fi
    echo $sf
    echo $mf
    echo 
    if [[ $sf != $mf ]] ; then
        (cd ${mega} && rm $mf $mf.sig)
        (cd ${src} && ln $sf ${mega} ; ln $sf.sig ${mega})
    else
        (cd ${src} && ln $sf ${mega} ; ln $sf.sig ${mega})
    fi
done

mega-rm -rf //bin/SyncDebris

