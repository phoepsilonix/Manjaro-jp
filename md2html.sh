#!/bin/sh

cd artifacts
for f in ./*.*.md
do
    f2=${f%.md}.html
    pulldown-cmark $f > $f2
done

