#!/bin/sh

cd artifacts
for f in ./*.*.md
do
    f2=${f%.md}.html
    echo $f $f2
    pulldown-cmark -TFSLPHM $f > $f2
    #pulldown-cmark -TFSLPH < $f > $f2
    #pulldown-cmark $f > $f2
done
touch -c *.ja.md *.ja.html
