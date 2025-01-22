#cat iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-*|sed 's|KERNEL|linux64|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'|xargs sudo pacman -Sw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils
#cat iso-profiles-orig/community/{cinnamon,mate,sway}/Packages-*|sed 's|KERNEL|linux64|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'|xargs sudo pacman -Sw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils
gpg -dq ~/.ssh/pass.gpg|sudo -S pwd
KERNEL=linux613
#cat Japanese-pkgs.txt Japanese-pkgs-root.txt iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/community/{cinnamon,mate,sway,budgie}/Packages-*|sed 's|KERNEL|linux67|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'| sort -u | xargs sudo pacman -Syyw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils systemd-libs polkit xorg-server-common
#cat Japanese-pkgs.txt Japanese-pkgs-root.txt iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/shared/Packages-* |sed "s|KERNEL|$KERNEL|"|sed -e 's|#.*||' |sed -e 's|^>.* ||'| sort -u | xargs sudo pacman -Syyw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils systemd-libs polkit xorg-server-common
cat Japanese-pkgs.txt Japanese-pkgs-root.txt iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/shared/Packages-* |sed "s|KERNEL|$KERNEL|"|sed -e 's|#.*||' |sed -e 's|^>.* ||' -e '/\.\.\/\.\./d'|sort -u | xargs sudo pacman -Syyw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils systemd-libs polkit xorg-server-common
#cat Japanese-pkgs.txt Japanese-pkgs-root.txt iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/shared/Packages-* |sed "s|KERNEL|$KERNEL|"|sed -e 's|#.*||' |sed -e 's|^>.* ||'| sort -u | sed -e '/470xx/d'|xargs sudo pacman -Syyw --noconfirm systemd-libs polkit xorg-server-common
#cat Japanese-pkgs.txt Japanese-pkgs-root.txt iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/shared/Packages-* |sed "s|KERNEL|$KERNEL|"|sed -e 's|#.*||' |sed -e 's|^>.* ||'| sort -u | xargs paru -Syyw --noconfirm



