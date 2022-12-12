# [Manjaro Linux JP](https://osdn.net/projects/manjaro-jp/)

## Japanese language support for [Manjaro Linux](https://manjaro.org/)
　Supports Japanese input and display by default, including live environment.
[kernel-6.0 series](https://kernel.org/).

GNOME, KDE, and Xfce will be available for official use.
The distribution files are ISO and some package files.
Please boot from a USB memory stick, etc. 
It may be easier to use [Ventoy](https://ventoy.net/) to boot from USB memory.
It is recommended to reformat the first partition with ext4 when installing Ventoy.

### Main Features
The Linux kernel is as up-to-date as possible.
The kernel is built using clang.
Japanese input (fcitx5-mozc) and Japanese fonts are installed as standard.
The flatpak version [Firefox](https://www.mozilla.org/ja/firefox/browsers/) or [Floorp](https://floorp.ablaze.one/) is used as the standard browser.
Standard installation of the flatpak version [LibreOffice](https://www.libreoffice.org) as office software.

ISOs for live environment & installation are available at the following distribution sites.
Please try it if you like.

##### Notes
1. secure boot is not supported
Please disable Secure Boot in your BIOS settings.
(If you want secure boot support, Ubuntu is a fast option, and Ubuntu Flavour offers several desktop environments). 

---
### Place of distribution
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A)

Thank you for the valuable storage space.
Distributed at the above 3 locations.

[MEGA Storage](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A") is recommended because it can upload file sizes of 4G or more.

---
### Memorandum
##### manjaro-tools-iso changes
1. the first line of the mirrorlist is used as standard for where to get the packages used for buildiso.
By default, the mirrorlist is not loaded and the EU server is used.
2. to prioritize the order of repositories specified in user-repos.conf in order to include the packages I have prepared in the ISO. This is mainly to include the latest version of the kernel.

### Update History
<details>
<summary>Our History</summary>

##### 20220401
kernel-5.17.1 (clang build)
linux517-broadcom-wl,linux517-zfs package was also built and added.
The modifications to the broadcom-wl-dkms package and other information can be found in the [Packages folder](https://gitlab.com/phoepsilonix/) in [gitlab](https://gitlab.com/phoepsilonix/manjaro-jp) manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms).

##### 20220408
The only standard browser is [Vivaldi](https://vivaldi.com/).
You are of course free to change to any other browser.
The initial value of GRUB at boot time in the live environment has been changed for Japan.

##### 20220411
Fixed a bug in package update.
Added Japanese fonts.
Morisawa BIZ UD font [Morisawa Inc.](https://www.morisawa.co.jp/) [released under SIL OFL license](https://www.morisawa.co.jp/about/news/6706) Morisawa BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho), [Morisawa BIZ UD Gothic](https://github.com/googlefonts/) morisawa-biz-ud-gothic) are preinstalled.
The fonts are the same as the ones released on Github. License file etc. are also included. (I also built it myself and found no differences in the binaries.)
For more information, please check the above original site or the Github document.
Support [Morisawa BIZ+ font](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/).

##### 20220413
Morisawa BIZ UD font package has been registered with AUR.

##### 20220414
Updated to kernel-5.17.3.

##### 20220421
Updated to kernel-5.17.4.

##### 20220422
Changed Japanese input to fcitx5-mozc.

##### 20220424
Enabled Japanese keyboard and Mozc by default.

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
The desktop environment GNOME has been updated to GNOME42.

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
Updated nvidia driver version to 515.43.04.
Added kernel-5.18 series.

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
Office Software Related Changes
Eliminated the selection of office software in the installer.
Mainly to reduce space requirements, we eliminated the selection of office software in the installer and changed the standard installed office software from onlyoffice-desktopeditor to libreoffice-fresh.

##### 20220611
kernel-5.17.14
kernel-5.18.3
Updated nvidia driver version to 515.48.07.
Fixed virtualbox-host-dkms to build on linux518.
Added nginx-quic package and other packages to manjaro-jp repository, although they are not included in ISO.
Included manjaro-jp repository in pacman.conf.

##### 20220614
Bug fixes in the installer.
Changed editor from gedit to gnome-text-editor in GNOME version.

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6
Switched from audio-related manjaro-pulse to manjaro-pipewire.

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8
nvidia-utils 515.57

##### 20220703
kernel-5.18.9

##### 20220706
cups-browsed enabled.
The ipp-usb package has been added.

##### 20220709
kernel-5.18.10

##### 20220714
kernel-5.18.11

##### 20220716
kernel-5.18.12

##### 20220725
kernel-5.18.14

##### 20220731
kernel-5.18.15

##### 20220805
kernel-5.18.16
nvidia-utils 515.65

##### 20220812
kernel-5.18.17

##### 20220819
kernel-5.18.18

##### 20220823
kernel-5.18.19

##### 20220827
kernel-5.19.4

##### 20220902
kernel-5.19.6

##### 20220907
kernel-5.19.7

##### 20220910
kernel-5.19.8

##### 20220917
kernel-5.19.9

##### 20220922
kernel-5.19.10

##### 20220925
kernel-5.19.11
nvidia-utils 515.76

##### 20221003
kernel-5.19.12

##### 20221006
kernel-5.19.14

##### 20221013
kernel-5.19.15
nvidia-utils 520.56.06-1

##### 20221016
kernel-5.19.16
nvidia-utils 520.56.06-2
</details>

##### 20221025
kernel-6.0.3
The standard browser was changed to [Floorp](https://floorp.ablaze.one/).

##### 20221105
kernel-6.0.7
mkinitcpio-32-2

##### 20221112
The flatpak version [Firefox](https://www.mozilla.org/ja/firefox/browsers/) or [Floorp](https://floorp.ablaze.one/) is used as the standard browser.
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10
Changed LibreOffice to the flatpak version.
Changed fcitx5's default keyboard to jp-kana86.
Set initial font for gnome-terminal.

##### 20221206
kernel-6.0.11

##### 20221210
kernel-6.0.12


---
Addendum for your reference.
If you have a PC with Linux installed, you can use an unofficial (no official support) dual boot environment with ChromeOS. If you have a PC with Linux installed, you can create a dual-boot environment with ChromeOS, which is unofficial (no official support). This is for those who have some knowledge.
If you are interested, please refer to [here](https://github.com/sebanc/brunch/blob/master/install-with-linux.md).

---
In the ArchLinux family, which features rolling releases, [Garuda Linux](https://garudalinux.org) also looks good.

---
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://osdn.net/projects/manjaro-jp/storage/manjaro-jp/
```
[manjaro-jp pkgs](https://osdn.net/projects/manjaro-jp/storage/manjaro-jp/)

[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/manjaro-jp/)
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)
[Manjaro-JP at sf web](https://manjaro-jp.sourceforge.io/)
(GPG signing public key:536487F1470D7187) <phoepsilonix at gmail dot com>
[revolut](https://revolut.me/phoepsilonix)
[paypal](https://paypal.me/phoepsilonix)

BTC
```3FNDG4oES4HmR5byStmAFMasdTyaYjus3k```
ETH
```0xe9968CFb2bc0D2aB789c45E31042938265A151Bb```
USDT(TRC20)
```TFmZcyVjobYKNUXeXLmWdj4ZphGU2tTptj```