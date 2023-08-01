 cat artifacts/README.*.md > jyouyou.txt

  pyftsubset  /usr/share/fonts/OTF/BIZ-UDPMincho-Medium.otf \
               --text-file=jyouyou.txt \
              --layout-features='*' \
              --flavor=woff2 \
              --font-number=0 \
              --output-file=BIZ-UDPMincho-Medium.woff2

 pyftsubset  /usr/share/fonts/OTF/BIZ-UDPMincho-Medium.otf \
               --text-file=jyouyou.txt \
              --layout-features='*' \
              --flavor=woff \
              --font-number=0 \
              --output-file=BIZ-UDPMincho-Medium.woff
 pyftsubset  /usr/share/fonts/OTF/BIZ-UDPGothic.otf \
               --text-file=jyouyou.txt \
              --layout-features='*' \
              --flavor=woff2 \
              --font-number=0 \
              --output-file=BIZ-UDPGothic.woff2
 pyftsubset  /usr/share/fonts/OTF/BIZ-UDPGothic.otf \
               --text-file=jyouyou.txt \
              --layout-features='*' \
              --flavor=woff \
              --font-number=0 \
              --output-file=BIZ-UDPGothic.woff
