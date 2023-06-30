#cat iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-*|sed 's|KERNEL|linux64|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'|xargs sudo pacman -Sw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils
#cat iso-profiles-orig/community/{cinnamon,mate,sway}/Packages-*|sed 's|KERNEL|linux64|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'|xargs sudo pacman -Sw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils
cat iso-profiles-orig/manjaro/{gnome,kde,xfce,architect}/Packages-* iso-profiles-orig/community/{cinnamon,mate,sway}/Packages-*|sed 's|KERNEL|linux64|'|sed -e 's|#.*||' |sed -e 's|^>.* ||'| sort -u | xargs sudo pacman -Sw --noconfirm lib32-nvidia-utils lib32-nvidia-390xx-utils lib32-nvidia-470xx-utils


