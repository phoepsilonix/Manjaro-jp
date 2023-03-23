#!/bin/sh

optimize_png() {
    for X in "$@"; do
        echo "---- Using pngcrush to strip irrelevant chunks from $X ----"
        # Because I don't know if OptiPNG considers them all "metadata"
        pngcrush -ow -q -rem alla -rem cHRM -rem gAMA -rem iCCP -rem sRGB \
            -rem time "$X" | egrep -v '^[ \|]\|'
    done

    echo "---- Using OptiPNG to optimize delta filters ----"
    # ...and strip all "metadata"
    optipng -clobber -o7 -zm1-9 -strip all -- "$@" 2>&1 | grep -v "IDAT size ="

}

optimize_png $@

convert $@ -define icon:auto-resize=32,160 -colors 256 -dither None -compress zip favicon.ico
