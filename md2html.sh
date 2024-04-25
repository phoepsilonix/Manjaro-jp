#!/bin/sh

cmd=pulldown-cmark
cmd=md2html
cd artifacts
for f in ./*.*.md
do
    f2=${f%.md}.html
    echo $f $f2
    $cmd -TFSLPHM $f > $f2
    #pulldown-cmark -TFSLPH < $f > $f2
    #pulldown-cmark $f > $f2
done
touch -c *.ja.md *.ja.html
