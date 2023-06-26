SRC=rsync://ftp.tsukuba.wide.ad.jp/manjaro

rsync -rtlvH --safe-links --delete-after --delay-updates $SRC/pool/{overlay,sync} manjaro/pool/
rsync -rtlvH --safe-links --delete-after --delay-updates $SRC/{stable,testing,unstable} manjaro/

