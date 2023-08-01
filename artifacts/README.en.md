# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)
### 
## Japanese language support for [Manjaro Linux](https://manjaro.org/)
　The default includes support for Japanese input and display, including the live environment.  
[kernel-6.4 series](https://kernel.org/).  

We plan to provide three types of official environments: KDE, Xfce, and GNOME.  
The distribution files include ISO and some package files.  
Please start from a USB memory or SSD disk, etc.  
Starting from a USB memory may be easier with [Ventoy](https://ventoy.net/).  
It is recommended to format the first partition as ext4 during the introduction of Ventoy.  

### Main Features
The Linux kernel is adopted with the latest version as much as possible.  
Clang is used for kernel building.  
Japanese input (fcitx5-mozc) and Japanese font are standardly installed.  
The standard browser is either the flatpak version of [Firefox](https://www.mozilla.org/ja/firefox/browsers/) or [Floorp](https://floorp.ablaze.one/).  
Flatpak version of [LibreOffice](https://www.libreoffice.org) is standardly installed as an office software.  
We have installed the pacman-static package as standard. Please use this if package updates become difficult due to library inconsistencies.  

The live environment & installation ISO is published at the following distribution site.  
Please feel free to try it out.

##### Notes
1. Does not support Secure Boot  
It is not supported, so please disable Secure Boot in BIOS settings.  
(If you want secure boot support, Ubuntu is faster. There are multiple desktop environments provided in [Ubuntu flavours](https://ubuntu.com/desktop/flavours).)

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

##### Addition: 2023-02-11
In the latest version (2023-02-11~) of [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), the above measures have been added.
Additionally, the installer has been modified to add a process to enable the swap partition during installation.
Feedback has already been provided to [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Addition: 2023-02-27
The above feedback indicates that swap may not be enabled depending on how the partition is configured.  
Therefore, as an additional measure, the use of zram-generator has been added.

---
### Place of distribution
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[<img src="data:image/png;base64,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" width="180">](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg) | [Manjaro-Linux-jp at Terabox](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg)  
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  

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

---
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
<details>
<summary>Our History</summary>

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
</details>

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


---
Note: As a reference, an additional note.  
If you have a PC with Linux installed, you can also create a dual-boot environment with (no official support) ChromeOS, as long as you have some knowledge.  
This is for those who are interested. Please refer to [this link](https://github.com/sebanc/brunch/blob/master/install-with-linux.md) for reference.([Japanese](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82))

---
Other recommended OS  
[Endless OS | Endless Computers](https://endlessos.com/)  

---
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://manjaro-jp.phoepsilonix.love/manjaro-jp/
#Server = https://manjaro-jp.sourceforge.io/manjaro-jp/
#Server = https://manjaro-jp.osdn.jp/manjaro-jp/
```

---
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
[manjaro-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix at phoepsilonix dot love>  

---
### Your support for this activity is very welcome.  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
