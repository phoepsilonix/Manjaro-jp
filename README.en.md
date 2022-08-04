# [Manjaro Linux JP](https://osdn.net/projects/manjaro-jp/)

## Japanese language support for [Manjaro Linux](https://manjaro.org/)
　Supports Japanese input and display by default, including live environment.
[kernel-5.18 series](https://kernel.org/).
5.17.15 (EOL) will also be built and distributed at OSDN.

GNOME, KDE, and Xfce will be available for official use.
The distribution files are ISO and some package files.
Please boot from a USB memory stick, etc. 
It may be easier to use [Ventoy](https://ventoy.net/) to boot from USB memory.
It is recommended to reformat the first partition with ext4 when installing Ventoy.

### Main Features
The Linux kernel is as up-to-date as possible.
The kernel is built using clang.
Japanese input (fcitx5-mozc) and Japanese fonts are installed as standard.
Use [Vivaldi](https://vivaldi.com/) as the standard browser.
Standard installation of [libreoffice-fresh](https://www.libreoffice.org) as office software.

ISOs for live environment & installation are available at the following distribution sites.
Please try it if you like.

##### Notes
1. secure boot is not supported
Please disable Secure Boot in your BIOS settings.
(If you want secure boot support, Ubuntu is a fast option, and Ubuntu Flavour offers several desktop environments). 

2. if Vivaldi displays an error message about insufficient video codecs
You may get an error message that there is not enough h.264 codec to play the video.
This is because it may take some time for Vivaldi to update its components. After a while, it will be updated automatically.
You can also manually update the Vivaldi components by going to [Vivaldi components screen ( vivaldi://components )](vivaldi://components). 

3. if the startup menu does not appear
The menu can be displayed by modifying /etc/default/grub and executing update-grub. 
The fix is to change GRUB_TIMEOUT_STYLE from hidden to menu.
After that, if you run update-grub with administrator privileges, the menu will be displayed from the next boot. If the file system is btrfs, you can choose to boot from snapshots, etc.
Change GRUB_TIMEOUT_STYLE=menu.
Set TIMEOUT to an appropriate number of seconds.
```sh
sudo nano /etc/default/grub
```

Then, execute the following command.
```sh
sudo update-grub
```

---
### Place of distribution
[<img src="https://osdn.net/sflogo.php?group_id=14185&type=1" width="180">](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[<img src="http://sourceforge.net/sflogo.php?group_id=66882&type=5" width="180">](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[<img src="https://s0.teraboxcdn.com/fe-opera-static/node-static-v4/fe-webv4-main/img/logo.4e10d647.png" width="180">](https://terabox.com/s/19YM2KYCFY1sPaIXz_W-i-A) | [Manjaro-Linux-jp at Terabox](https://terabox.com/s/19YM2KYCFY1sPaIXz_W-i-A)  

Thank you for the valuable storage space.
Distributed at the above 3 locations.

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
</details>

##### 20220805
kernel-5.18.16
nvidia-utils 515.65


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
Bitcoin
1F9BNxvoBfxYm4E1PqF6J9FYqyCtLypdP
Ethreum
0x680932c238653da1d9d0950153c8a2b9d8f76a3e
