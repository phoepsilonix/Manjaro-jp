# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) 日語支援

默認支援日語輸入和日語顯示，包括即時ISO(現場ISO)。  
[kernel-6.7.x](https://kernel.org/).

按照公式，我們計劃準備三種類型：KDE、Xfce、GNOME。  
分發檔是 ISO 和一些包檔。  
從U盤啟動。  
使用 Ventoy 從 U 盤啟動可能更容易。  
建議在部署 Ventoy 時用 ext4 重新格式化第一個分區。  

----
### 關於安裝Ventoy
使用Manjaro Linux將ventoy安裝到USB驅動器的步驟
```
sudo pacman -S ventoy
ventoygui
```
一般Linux  
使用aria2的下載命令示例  
```
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.96/ventoy-1.0.96-linux.tar.gz
tar xf ventoy-1.0.96-linux.tar.gz
cd ventoy-1.0.96
./VentoyGUI.x86_64 
```

Windows  
使用瀏覽器或其他方式下載[Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.0.96/ventoy-1.0.96-windows.zip)。  
打開下載的zip文件並運行ventoy2disk.exe

----
### 主要特點

Linux kernel應該盡可能是最新的。  
此外，clang 用於構建kernel。  
日語輸入(fcitx5-mozc)，日語字體作為標準安裝。  
採用[floorp](https://floorp.ablaze.one)作為標準瀏覽器。  
LibreOffice作為辦公軟體作為標準安裝。  
我們已預設安裝了pacman-static套件。如果因為函式庫的不合一致，導致套件更新變得困難，請使用它。

##### 注意事項
1. 不支援安全啟動  
它不受支援，因此請在BIOS設置中禁用安全啟動。  
（如果你想要安全啟動支援，[Ubuntu][Ubuntu] 更快。 [Ubuntu flavours][Ubuntu flavours] 還提供多個桌面環境。）

[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. 如果安裝程式螢幕在安裝過程中消失  
通常可以通過手動設置交換分區來避免它。  
如果交換分區是 /dev/sdX，請嘗試使用如下命令手動啟用交換：
```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# 如果未啟用交換，請檢查 lsblk 中的設備以啟用交換分區。
[[ $（swapon --show） == “” ]] && SWAP=$（lsblk -l -f -n -p | awk '{if （$2==“swap”） print $1}'） && （ sudo swapon $SWAP || （sudo mkswap $SWAP && sudo swapon $SWAP）
```

此外，使用以下命令，讓我們指定它不受 OOM killer（強制退出）的約束。
```
皮多夫 -xw Xwayland calamares_polkit | xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

3. 在某些应用程序中无法输入日文时  
如果仍保留旧设置并在 gtk-im-module 中进行了某些设置，可能会出现在某些应用程序中无法输入日语的情况。
```
gsettings get org.gnome.desktop.interface gtk-im-module
```
如果该命令显示 "gtk-im-context-simple "或类似设置，请使用以下命令删除该设置。
```
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

##### 附加說明： 2023-02-11  
[Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/) 在最新版本的（2023-02-11-）中，增加了上述措施。  
我們還修改了安裝程式，以添加一個進程，以便在安裝期間啟用交換分區。
魷魚也有[反饋](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe)。

----
### 分發位置
實時環境和安裝 ISO 可在以下分發目標獲得。  
如果您願意，請嘗試一下。  

[![MEGA][MEGA-ICON]][MEGA-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-mega.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/mega-icon.svg"/></svg>][MEGA-folder]
---|---
[![SourceForge][SF-ICON]][SOURCEFORGE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-sourceforge.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/sourceforge-icon.svg"/></svg>][SOURCEFORGE-folder]
[![Google Drive][GD-ICON]][GOOGLE-DRIVE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-google.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/Google_Drive_icon.svg"/></svg>][GOOGLE-DRIVE-folder]
[![Terabox][TERA-ICON]][TERABOX-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-terabox.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/terabox_logo.svg"/></svg>][TERABOX-folder]

[MEGA-folder]: https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0 "MEGA"
[SOURCEFORGE-folder]: https://sourceforge.net/projects/manjaro-jp/ "SourceForge"
[GOOGLE-DRIVE-folder]: https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing "Google Drive"
[TERABOX-folder]: https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag "TeraBox"
[MEGA-ICON]: ./img/mega-icon.svg
[SF-ICON]: ./img/sf_logo.png
[GD-ICON]: ./img/Google_Drive_icon.svg
[TERA-ICON]: ./img/terabox_logo.svg

感謝您的寶貴存儲空間。  
分佈於以上三地。

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0) 建議使用 ，因為它也可以上傳大於 4G 的檔。

如果你想用命令列從MEGA Storage下載，megatools很方便。
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
### 註釋
##### 對 manjaro-tools-iso 的更改
1. 鏡像清單的第一行是用於構建的套件的標準目的地。  
默認情況下，不讀取鏡像清單，並使用 EU 伺服器。
2. 為了優先將我準備好的套件包含在 ISO 中，優先考慮 user-repos.conf 中指定的存儲庫的順序。  
主要包括最新版本的kernel。

### 更新歷史記錄
<details><summary>迄今為止的歷史</summary>

##### 20220401
kernel-5.17.1（克隆構建）  
Linux517-Broadcom-WL，Linux517-ZFS軟體包也被構建和添加。  
有關對 broadcom-wl-dkms 軟體包的修改，https://gitlab.com/phoepsilonix/Manjaro-jp 請參閱 [包資料夾](https://gitlab.com/phoepsilonix/Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms)。

##### 20220408
標準瀏覽器現在只有[Vivaldi](https://vivaldi.com/)。  
當然，您可以自由地將其更改為其他瀏覽器。  
實時環境引導時的預設 GRUB 值現在面向日本。

##### 20220411
包更新中的錯誤修復。  
添加日語字體。  
[森澤公司](https://www.morisawa.co.jp/) [根據SIL OFL許可證發佈](https://www.morisawa.co.jp/about/news/6706)
森澤BIZ UD字體[森澤BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho)，[森澤BIZ UD哥特式](https://github.com/googlefonts/morisawa-biz-ud-gothic) 預裝。  
它是在Github上發佈的字體的記錄。 還包括許可證檔。 （我也自己構建了它，但二進位檔有所不同沒有。)
有關詳細資訊，請查看上述網站和 Github 文件。  
[森澤BIZ+字體 讓我們支援](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/)。

##### 20220413
我們已經在UR中註冊了Morisawa BIZ UD字體包。

##### 20220414
更新到kernel-5.17.3。

##### 20220421
更新到kernel-5.17.4。

##### 20220422
日語 將輸入更改為fcitx5-mozc。

##### 20220424
日語啟用鍵盤和Mozc作為標準。

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
桌面環境 GNOME 已更新到 GNOME 42。

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
已將 NVIDIA 驅動程式版本更新為 515.43.04。
添加了kernel-5.18 系列。

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
與辦公軟體相關的更改  
消除了安裝程式中辦公軟體的選擇。  
主要是為了減少容量，我們取消了安裝程式中辦公軟體的選擇，並將要安裝的標準辦公軟體從onlyoffice-desktopeditor更改為libreoffice-fresh。

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
nvidia-utils 520.56.06

##### 20221016
kernel-5.19.16  
nvidia-utils 520.56.06-2

##### 20221025
kernel-6.0.3  
已將標準瀏覽器更改為 [Floorp](https://floorp.ablaze.one/)。

##### 20221105
kernel-6.0.7  
甲基吡啶-32-2

##### 20221112
使用flatpak版本[Firefox](https://www.mozilla.org/ja/firefox/browsers/)或[Floorp](https://floorp.ablaze.one/)作為標準瀏覽器。  
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10  
將 LibreOffice 更改為 flatpak 版本。  
將FCITX5的默認鍵盤更改為日語（假名86）。  
將 gnome-terminal 的初始字體更改為 FirgeNerd 控制台。  
以下字體已預安裝。  
[Firge：Firge，一種合成Fira Mono和Genshin Gothic的程式設計字體](https://github.com/yuru7/Firge)  
[HackGen：合成Hack和Genju Gothic Hakugen（HackGen）的程式設計字體](https://github.com/yuru7/HackGen)

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

##### 20230210
kernel-6.1.11  
英偉達實用工具 525.89.02  
Manjaro-jp 儲存庫 URL 已更改。  
（OSDN 到 OSDN Web。 這可能是暫時的。 ）  
ISO檔通過[SourceForge](https://sourceforge.net/projects/manjaro-jp/)分發。  
我們對 Calamares 安裝程式進行了一些更改。  
（減少安裝程式在重負載下崩潰的情況。 ）   

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

* 我們已經發佈了一個暫時未經驗證的軟體包。  
很抱歉給您帶來麻煩，但請嘗試使用以下命令重新安裝 Manjaro 官方分發的軟體包。
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
我已經準備了一個安裝manjaro-jp簽名鑰匙的包。  
如果因為manjaro-jp簽名鑰匙出現錯誤，請嘗試以下的命令來修復它。  
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
當執行軟體的新增和刪除（pamac update）時，在已簽名數據庫的存儲庫中更新簽名文件時會出現問題。  
為了解決這個問題，我已對pacman包進行了微調。  

##### 20230731
* 我在安裝環境中設定了讀取manjaro_jp的簽名金鑰檔案。(calamares)

我认为，通过我先前对pacman包的修正以及消除签名键中的不一致，应该已经消除了错误发生的情况。  
然而，如果出现错误，请尝试以下步骤。  

初始化签名键数据库。
```
sudo pacman-key --init
sudo pacman-key --populate
```

重新加载包信息。
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* 修复了以下问题：在[添加/删除软件]更新检查后导致包信息损坏和意外终止。(pamac)。
* 在[添加/删除软件]中搜索已安装的软件包时，flatpak和snap应用程序现在包含在搜索中（libpamac）。   

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
</details>

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


----
其他推薦的操作系統  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE MicroOS](https://get.opensuse.org/zh-CN/microos/)  

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
### 對於這個活動的支持，我們非常歡迎。
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
