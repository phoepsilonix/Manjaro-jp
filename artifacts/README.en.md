# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)
### 
## Japanese language support for [Manjaro Linux](https://manjaro.org/)
　The default includes support for Japanese input and display, including the live environment.  
[kernel-6.8 series](https://kernel.org/).  

We plan to provide three types of official environments: KDE, Xfce, and GNOME.  
The distribution files include ISO and some package files.  
Please start from a USB memory or SSD disk, etc.  
Starting from a USB memory may be easier with [Ventoy](https://ventoy.net/).  
It is recommended to format the first partition as ext4 during the introduction of Ventoy.  

----
### About installing Ventoy
Steps to install ventoy on a USB drive using Manjaro Linux  
```
sudo pacman -S ventoy
ventoygui
```

General Linux  
Example of download command using aria2  
```
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-linux.tar.gz
tar xf ventoy-1.0.97-linux.tar.gz
cd ventoy-1.0.97
./VentoyGUI.x86_64
```

Windows  
Download [Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-windows.zip) using a browser or something.  
Open the downloaded zip file and run ventoy2disk.exe.

----
### Main Features
The Linux kernel is adopted with the latest version as much as possible.  
Clang is used for kernel building.  
Japanese input (fcitx5-mozc) and Japanese font are standardly installed.  
The standard browser is either the flatpak version of [Firefox](https://www.mozilla.org/ja/firefox/browsers/) or [Floorp](https://floorp.ablaze.one/).  
Flatpak version of [LibreOffice](https://www.libreoffice.org) is standardly installed as an office software.  
We have installed the pacman-static package as standard. Please use this if package updates become difficult due to library inconsistencies.  

##### Notes
1. Does not support Secure Boot  
It is not supported, so please disable Secure Boot in BIOS settings.  
(If you want secure boot support, [Ubuntu][Ubuntu] is faster. There are multiple desktop environments provided in [Ubuntu flavours][Ubuntu flavours].)

[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. If the installer screen disappears during installation  
In many cases, it can be avoided by setting the swap partition manually.  
If the swap partition is /dev/sdX, try to manually enable swap with the following command.  
```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# If swap is not enabled, use lsblk to examine the device and enable the swap partition.
[[ $(swapon --show) == "" ]] &&  SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```

Also, specify the target that is excluded from OOM killer (force termination) with the following command.
```
pidof -xw Xwayland calamares_polkit|xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

3. When Japanese input is not possible in some apps  
If old settings remain and something has been set in gtk-im-module, there may be cases where you cannot input Japanese in some apps.
```
gsettings get org.gnome.desktop.interface gtk-im-module
```
If this command shows 'gtk-im-context-simple' or similar, remove the setting with the following command.
```
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

4. kernel differences from the official Manjaro kernel
The kererl-6.6 series is used in the official Manjaro iso, but the iso distributed here uses the newest kernel possible. Currently, it is kernel-6.8 series.  
We use clang instead of gcc to build the kernel and kernel modules.  
We also enable the kernel's rust support.  
If you want to use the official Manjaro kernel, install it by specifying the repository `core` as in the following command.
```
sudo pacman -S core/linux66 core/linux66-headers
```

##### Addition: 2023-02-11
In the latest version (2023-02-11~) of [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), the above measures have been added.
Additionally, the installer has been modified to add a process to enable the swap partition during installation.
Feedback has already been provided to [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Addition: 2023-02-27
The above feedback indicates that swap may not be enabled depending on how the partition is configured.  
Therefore, as an additional measure, the use of zram-generator has been added.

----
### Place of distribution
he live environment & installation ISO is published at the following distribution site.  
Please feel free to try it out.

[![MEGA][MEGA-ICON]][MEGA-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-mega.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/mega-icon.svg"/></svg>][MEGA-folder]
---|---
[![SourceForge][SF-ICON]][SOURCEFORGE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-sourceforge.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/sourceforge-icon.svg"/></svg>][SOURCEFORGE-folder]
[![Google Drive][GD-ICON]][GOOGLE-DRIVE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-google.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/Google_Drive_icon.svg"/></svg>][GOOGLE-DRIVE-folder]
[![pCloud][pCloud-ICON]][pCloud-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-pcloud.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/pcloud_icon.svg"/></svg>][pCloud-folder]
[![Terabox][TERA-ICON]][TERABOX-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-terabox.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/terabox_logo.svg"/></svg>][TERABOX-folder]

[MEGA-folder]: https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0 "MEGA"
[SOURCEFORGE-folder]: https://sourceforge.net/projects/manjaro-jp/ "SourceForge"
[GOOGLE-DRIVE-folder]: https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing "Google Drive"
[TERABOX-folder]: https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag "TeraBox"
[pCloud-folder]: https://u.pcloud.link/publink/show?code=kZVuHNVZ0ljg4O7Ja2j8YN9KNwFVnfsnoCnX
[MEGA-ICON]: ./img/mega-icon.svg
[SF-ICON]: ./img/sf_logo.png
[GD-ICON]: ./img/Google_Drive_icon.svg
[TERA-ICON]: ./img/terabox_logo.svg
[pCloud-ICON]: ./img/pcloud_icon.svg

Thank you for the valuable storage.  
It is distributed in the above three places.

[MEGA Storage](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A") is recommended as you can upload files larger than 4G.

If you want to download from MEGA Storage using the command line, megatools is useful.
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
### Memo
##### Changes in manjaro-tools-iso
1. The source of the packages used in buildiso is set to the first line of the mirrorlist as the standard.  
By default, the mirrorlist is not loaded and the EU server is used.  
2. To prioritize inclusion of packages that I have prepared, the priority of the repository specified in user-repos.conf has been given priority.  
Mainly to include the latest version of the kernel.  
3. Calamares Installer Adjustments  
At the time of starting the installer, if a swap partition exists, the swap has been enabled.  
Because the mount may be removed during installation, the process to re-enable the swap partition has been added before the copying of the installation files begins.  
In addition, by specifying programs that are not subject to OOM killer, which is a function to forcibly terminate a program by the kernel under high loads, the installation has been adjusted so that it does not forcibly terminate.

### Update History
<details><summary>Our History</summary>

##### 20220401
kernel-5.17.1 (clang build)  
linux517-broadcom-wl,linux517-zfs package was also built and added.  
The modifications to the broadcom-wl-dkms package and other information can be found in the [Packages folder](https://gitlab.com/phoepsilonix/Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms).

##### 20220408
The only standard browser is [Vivaldi](https://vivaldi.com/).  
You are of course free to change to any other browser.  
The initial value of GRUB at boot time in the live environment has been changed for Japan.

##### 20220411
Fixed a bug in package update.  
Added Japanese fonts.  
Morisawa BIZ UD font [Morisawa Inc.](https://www.morisawa.co.jp/) [released under SIL OFL license](https://www.morisawa.co.jp/about/news/6706)  
[Morisawa BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho), [Morisawa BIZ UD Gothic](https://github.com/googlefonts/morisawa-biz-ud-gothic) are preinstalled.  
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
Office Software Related Changes.  
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
The initial font of gnome-terminal has been changed to FirgeNerd Console.  
The following fonts are now pre-installed.  
[Firge: programming font synthesised from Fira Mono and Genjyu Gothic Firge (Firge)](https://github.com/yuru7/Firge)  
[HackGen: programming font combining Hack and Genju Gothic Hakugen (HackGen)](https://github.com/yuru7/HackGen)

##### 20221206
kernel-6.0.11

##### 20221210
kernel-6.0.12

##### 20221215
kernel-6.0.13

##### 20221220
kernel-6.0.14

##### 20221224
kernel-6.0.15

##### 20230101
kernel-6.1.2

##### 20230107
kernel-6.1.3  
nvidia-utils 525.78.01

##### 20230108
kernel-6.1.4

##### 20230113
kernel-6.1.5

##### 20230116
kernel-6.1.6

##### 20230120
kernel-6.1.7  
nvidia-utils 525.85.05

##### 20230127
manjaro-release 22.0.1  
kernel-6.1.8  
nvidia-utils 525.85.05

##### 20230204
manjaro-release 22.0.2  
kernel-6.1.9

##### 20230211
kernel-6.1.11
nvidia-utils 525.89.02  
The URL of Manjaro-jp repository has been changed from OSDN to OSDN Web. (It may be temporary.)  
The ISO files are distributed on [SourceForge](https://sourceforge.net/projects/manjaro-jp/).  
A few modifications have been made to the Calamares installer. (Reducing the cases where the installer is forcibly terminated during high loads.)  

##### 20230214
manjaro-release 22.0.3  

##### 20230217
kernel-6.1.12

##### 20230223
manjaro-release 22.0.4  
kernel-6.2

##### 20230227
kernel-6.2.1  
zram-generator

##### 20230304
kernel-6.2.2  

##### 20230306
sway

##### 20230315
kernel-6.2.6  
[fcitx5-mozc-with-jp-dict](https://aur.archlinux.org/packages/fcitx5-mozc-with-jp-dict)

##### 20230318
manjaro-release 22.0.5  
kernel-6.2.7  

* We have temporarily released a package that has not been fully tested to work.  
Please try to reinstall the package distributed by the Manjaro official distribution with the following command.
```
sudo pacman-static -S core/curl
```

##### 20230324
kernel-6.2.8

##### 20230401
kernel-6.2.9

##### 20230407
kernel-6.2.10

##### 20230414
kernel-6.2.11

##### 20230422
kernel-6.2.12

##### 20230427
kernel-6.2.13

##### 20230503
kernel-6.2.14

##### 20230513
kernel-6.2.15

##### 20230518
kernel-6.2.16

##### 20230525
kernel-6.1.30

##### 20230607
kernel-6.1.32

##### 20230611
kernel-6.3.7

##### 20230615
kernel-6.3.8  
nvidia-utils-535.54.03

##### 20230622
kernel-6.3.9  

##### 20230627
kernel-6.4.0  

##### 20230629
nvidia-470xx-utils-470.199.02-2

##### 20230703
kernel-6.4.1  

##### 20230707
kernel-6.4.2

##### 20230712
kernel-6.4.3  

##### 20230720
kernel-6.4.4

##### 20230721
I have prepared a package to install the manjaro-jp signature key.  
If an error occurs due to the manjaro-jp signature key, please try the following command to fix it.  
```
sudo pacman-key --populate manjaro_jp
sudo pacman -Sy
```

##### 20230724
kernel-6.4.5

##### 20230725
kernel-6.4.6

##### 20230728
kernel-6.4.7

##### 20230729
When adding and removing software (pamac update), an issue occurs while updating the signature file in the repository of the signed database.  
To solve this problem, I have fine-tuned the pacman package.  

##### 20230731
* I have set it up to load the manjaro_jp signature key file in the installation environment.(calamares)

I think that with the correction of the pacman package that I made earlier and the elimination of inconsistencies in the signature keys, cases of errors occurring should have been eliminated.  
However, if an error does occur, please try the following steps.  

Initialize the signature key database.
```
sudo pacman-key --init
sudo pacman-key --populate
```

Reload package information.
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* Fixed an issue where after the [Add/Remove Software] update check resulted in corrupted package information and unexpected termination. (pamac)  
* When searching for installed packages in [Add/Remove Software], flatpak and snap applications are now included in the search (libpamac).   

kernel-6.4.8

##### 20230813
kernel-6.4.10

##### 20230817
kernel-6.4.11

##### 20230824
kernel-6.4.12

##### 20230825
LibreOffie 7.6.0

##### 20230831
kernel-6.4.13

##### 20230903
kernel-6.4.14

##### 20230907
kernel-6.4.15

##### 20230914
kernel-6.4.16

##### 20230925
kernel-6.5.5

##### 20230928
libreoffice 7.6.2.1(flatpak)

##### 20231008
kernel-6.5.6  
glibc 2.38-5

##### 20231010
glibc 2.38-7

##### 20231012
kernel-6.5.7  

##### 20231023
kernel-6.5.8  

##### 20231027
kernel-6.5.9  

##### 20231103
kernel-6.5.10  
[ibus-mozc-with-jp-dict](https://aur.archlinux.org/packages/ibus-mozc-with-jp-dict)  

##### 20231110
kernel-6.6.1  

##### 20231121
kernel-6.6.2  

manjaro-jp database signatures have been removed. Only the package will be signed.  
If you get a signature error with pamac, try the following command.
```
sudo rm /var/tmp/pamac/dbs/sync/manjaro-jp*sig
sudo rm /var/lib/pacman/sync/manjaro-jp*sig
sudo pacman-key --populate
sudo pacman -Syy
```

##### 20231201
kernel-6.6.3  

##### 20231204
kernel-6.6.4  

##### 20231215
kernel-6.6.7

##### 20240107
kernel-6.6.10

##### 20240113
kernel-6.7

##### 20240127
kernel-6.7.2

##### 20240206
kernel-6.7.4

##### 20240218
kernel-6.7.5

##### 20240225
kernel-6.7.6
</details>

##### 20240303
kernel-6.7.8

##### 20240307
kernel-6.7.9

##### 20240316
kernel-6.7.10

##### 20240325
kernel-6.8.1

##### 20240328
kernel-6.8.2


----
Other recommended OS  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE MicroOS](https://get.opensuse.org/microos/)  

----
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://manjaro-jp.phoepsilonix.love/manjaro-jp/
#Server = https://manjaro-jp.sourceforge.io/manjaro-jp/
```

----
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix at phoepsilonix dot love>  

----
### Your support for this activity is very welcome.  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
