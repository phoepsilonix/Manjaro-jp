#!/bin/sh

cd artifacts
for f in ./*.*.md
do
    f2=${f%.md}.html
    pulldown-cmark -TFSLPH < $f > $f2
    #pulldown-cmark $f > $f2
done
touch *.ja.md *.ja.html
