# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) 日語支援

包含咧即時環境,一開始就會裝日文輸入同顯示。
採用[kernel-6.9系列](https://kernel.org/)。

預計會像官方版一樣,提供KDE、Xfce、GNOME三種桌面環境。
發佈檔案是ISO同一部份套件檔案,可以從USB記憶體等啟動。

使用[Ventoy](https://ventoy.net/)從USB啟動會較方便,不過在裝Ventoy的時陣最好先將第一個分區重新格式化做ext4。

----
### Ventoy的安裝
若係Manjaro Linux,可以按呢種作法:
```bash
sudo pacman -S ventoy
ventoygui
```
如果係Linux全般,而且下載用的是aria2,作法係:
```bash
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.98/ventoy-1.0.98-linux.tar.gz
tar xf ventoy-1.0.98-linux.tar.gz
cd ventoy-1.0.98
./VentoyGUI.$(uname -m)
```

如果係Windows,可以去Ventoy[官網](https://github.com/ventoy/Ventoy/releases/)下載,接著解開下載的zip檔案,直接執行ventoy2disk.exe就好矣。

----
### Manjaro-JP的主要特色

採用較新的Linux kernel,並且用clang來編譯kernel。
預設就裝好日文輸入法(Mozc)同日文字型。  
標準瀏覽器採用[Floorp](https://floorp.ablaze.one/)。  
辦公室套件預設裝[LibreOffice](https://ja.libreoffice.org)。  
標準裝pacman-static,如果因為函式庫衝突導致更新有問題,可以用pacman-static來更新。

##### 注意事項
1. 不支援安全開機
需要在BIOS關閉安全開機才能安裝,不過安裝後可以再啟用。
(如果需要支援安全開機,[Ubuntu][Ubuntu]會較簡單。佇[Ubuntu flavours][Ubuntu flavours]有提供幾種桌面環境。日文支援也會較簡單。)
[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. 即時環境無法安裝snap應用程式
安裝後就會啟用,但若真係一定想試,也可以手動啟用。
```bash
sudo systemctl start snapd.service
```

3. 如果安裝的時陣畫面消失
可以手動設定swap分區來解決。
如果swap分區是/dev/sdX,可以用下面的指令手動啟用swap:
```bash
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
如果swap沒啟用,可以用lsblk來檢查裝置,接著啟用swap分區:
```bash
[[ $(swapon --show) == "" ]] && SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```
另外,可以用下面的指令來設定OOM killer(強制終止程序)的例外對象:
```bash
pidof -xw calamares_polkit | xargs -n1 sudo choom -n -1000 -p
```

4. 部分應用程式無法輸入日文
如果有古老的設定猶原存在,而且 `gtk-im-module` 有設定,會導致部分應用程式無法輸入日文。
```bash
gsettings get org.gnome.desktop.interface gtk-im-module
```
如果這個指令會顯示 `gtk-im-context-simple` 之類的結果,代表有設定值存在。這時就需要用下面的指令來清除設定:
```bash
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

5. kernel版本比官方Manjaro新
kererl-6.6系列在Manjaro官方的iso中被採用了。最新的Manjaro似乎已經轉移到kernel-6.9系列了。
這裡分發的iso儘可能採用新的kernel。目前是kernel-6.9系列。
kernel同kernel模組的編譯是用clang,而不是gcc。
另外kernel也有支援rust。

如果需要Manjaro官方的kernel,可以指定core repository來裝:
```sh
sudo pacman -S core/linux66 core/linux66-headers
```
```sh
sudo pacman -S core/linux69 core/linux69-headers
```

##### 附加說明： 2023-02-11  
[Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/) 在最新版本的（2023-02-11-）中，增加了上述措施。  
我們還修改了安裝程式，以添加一個進程，以便在安裝期間啟用交換分區。
魷魚也有[反饋](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe)。

----
### 分發位置
即時環境同安裝用的ISO會佇下面分發。  
如果您願意，請嘗試一下。  

[![SourceForge][SF-ICON]][SOURCEFORGE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-sourceforge.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/sourceforge-icon.svg"/></svg>][SOURCEFORGE-folder]
---|---
[![pCloud][pCloud-ICON]][pCloud-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-pcloud.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/pcloud_icon.svg"/></svg>][pCloud-folder]
[![MEGA][MEGA-ICON]][MEGA-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-mega.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/mega-icon.svg"/></svg>][MEGA-folder]
[![Terabox][TERA-ICON]][TERABOX-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-terabox.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/terabox_logo.svg"/></svg>][TERABOX-folder]
[![Google Drive][GD-ICON]][GOOGLE-DRIVE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-google.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/Google_Drive_icon.svg"/></svg>][GOOGLE-DRIVE-folder]

[MEGA-folder]: https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0 "MEGA"
[SOURCEFORGE-folder]: https://sourceforge.net/projects/manjaro-jp/ "SourceForge"
[GOOGLE-DRIVE-folder]: https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing "Google Drive"
[TERABOX-folder]: https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag&path=%2Fmanjaro-jp "TeraBox"
[pCloud-folder]: https://u.pcloud.link/publink/show?code=kZVuHNVZ0ljg4O7Ja2j8YN9KNwFVnfsnoCnX
[MEGA-ICON]: ./img/mega-icon.svg
[SF-ICON]: ./img/sourceforge-icon.svg
[GD-ICON]: ./img/Google_Drive_icon.svg
[TERA-ICON]: ./img/terabox_logo.svg
[pCloud-ICON]: ./img/pcloud_icon.svg

感謝你們提供寶貴的儲存空間。
我們會佇這些所在分發檔案。

Terabox會分割上傳大於4GB的檔案,因為會產生費用。下載之後請先將檔案合併做一個檔案才使用。Mac同ios可以用keka,Windows可以用7-zip操作會較簡單。

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0)就可以上傳大於4GB的檔案,所以我們建議使用。  
[pCloud](https://partner.pcloud.com/r/119318)也可以處理大於4GB的檔案,是一種終身購買型的雲端儲存服務。

如果用指令佇MEGA Storage下載,megatools會較方便。

```bash
sudo pacman -S megatools
```
```bash
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
### 備忘錄
##### manjaro-tools-iso的變更
1. 用來建置ISO的套件下載來源,設定做讀取mirror list的第一行。
預設讀取的是歐洲的server。

2. 為了優先包含自己準備的套件,設定user-repos.conf來提高該repository的優先順序。
主要是為了包含最新版的kernel。

### 更新歷程
<details><summary>以前的進展</summary>
##### 20220401
採用kernel-5.17.1 (clang編譯)
也編譯了linux517-broadcom-wl同linux517-zfs套件並加入。
對broadcom-wl-dkms套件的修正詳情,請參考[gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp)的[Packages資料夾](https://gitlab.com/phoepsilonix/Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms)。

##### 20220408
標準瀏覽器改用[Vivaldi](https://vivaldi.com/)。
當然其他瀏覽器也可以自由更改。
調整了Live環境開機時GRUB的預設值為日本向。

##### 20220411
修正了套件更新的問題。
加入日文字型。
預裝了[Morisawa Inc.](https://www.morisawa.co.jp/)在[SIL OFL授權](https://www.morisawa.co.jp/about/news/6706)下發佈的[Morisawa BIZ UD明朝](https://github.com/googlefonts/morisawa-biz-ud-mincho)同[Morisawa BIZ UDゴシック](https://github.com/googlefonts/morisawa-biz-ud-gothic)字型。
直接使用佇Github公開的字型檔案,也包含授權文件。(我自己編譯的話,二進位檔案是無差異的)
詳細資訊請參考官方網站或Github上的文件說明。
請大家支持[Morisawa BIZ+ 字型](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/)。

##### 20220413
將Morisawa BIZ UD字型套件登錄到AUR。

##### 20220414
更新到kernel-5.17.3。

##### 20220421
更新到kernel-5.17.4。

##### 20220422
將日文輸入法改為fcitx5-mozc。

##### 20220424
預設啟用日文鍵盤同Mozc輸入法。

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
GNOME桌面環境更新到GNOME 42。

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
nvidia驅動程式更新到515.43.04版。
加入kernel-5.18系列。

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
辦公室軟體相關變更
移除安裝程式中的辦公室軟體選項。
為了減少容量,移除了安裝程式中的辦公室軟體選項,將預設安裝的辦公室軟體從onlyoffice-desktopeditor改為libreoffice-fresh。

##### 20220611
kernel-5.17.14
kernel-5.18.3
nvidia驅動程式更新到515.48.07版。
修正virtualbox-host-dkms可以用linux518編譯。
將manjaro-jp repository加入pacman.conf。

##### 20220614
修正安裝程式的bug。
GNOME版本將文字編輯器從gedit改為gnome-text-editor。

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6
將音訊相關的manjaro-pulse改為manjaro-pipewire。

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8
nvidia-utils 515.57

##### 20220703
kernel-5.18.9

##### 20220706
啟用cups-browsed。
加入ipp-usb套件。

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
nvidia-utils 520.56.06

##### 20221016
kernel-5.19.16
nvidia-utils 520.56.06-2

##### 20221025
kernel-6.0.3
將標準瀏覽器改為[Floorp](https://floorp.ablaze.one/)。

##### 20221105
kernel-6.0.7
mkinitcpio-32-2

##### 20221112
標準瀏覽器採用flatpak版[Firefox](https://www.mozilla.org/ja/firefox/browsers/)或[Floorp](https://floorp.ablaze.one/)。
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10
將LibreOffice改為flatpak版本。
調整fcitx5初始設定的鍵盤為日文(kana 86)。
將gnome-terminal的初始字型改為FirgeNerd Console。
預裝以下字型:
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
nvidia-utils更新到525.89.02版本  
改變Manjaro-jp的repository網址  
(從OSDN改為OSDN Web,可能是暫時性的變更)  

ISO檔案會佇[SourceForge](https://sourceforge.net/projects/manjaro-jp/)上面分發  
對Calamares安裝程式做一些修改  
(可以減少安裝程式在高負荷狀況下被強制終止的情況)  

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

* 我們一時性予發佈無夠檢查就緒的套件。
不好意思攏予你帶來麻煩,請用下面的指令重新裝一下Manjaro官方發佈的套件。
```bash
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
我們有一个安裝manjaro-jp簽名鍵的套件。  
如果發生因為manjaro-jp簽名鍵的錯誤,請用下面的指令來處理:
```bash
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
當執行軟體的新增同刪除(pamac update)的時陣,有發生佇提供簽名資料庫的repository,簽名檔案無法正常更新的問題。
為了解決是件代誌,我們對pacman套件做一些微調整。

##### 20230731
* 我們予安裝目的地的環境載入manjaro_jp的簽名鍵檔案。(calamares)
閣予早先對pacman套件的修正做伙,應該會免受簽名鍵無夠整齊而產生錯誤的情況。
但若果真有錯誤發生,請試試下面的步驟:

初始化簽名鍵資料庫
```bash
sudo pacman-key --init
sudo pacman-key --populate
```

重新載入套件資訊
```bash
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* 佇[軟體的新增同刪除]的時陣,更新檢查之後,修正一个問題,就是套件資訊會損毀而無法正常結束的情況。(pamac)
* 佇[軟體的新增同刪除]的時陣,若是尋找已經裝的套件,會連flatpak同snap的應用程式也納入尋找的對象。(libpamac)
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

我們予manjaro-jp的資料庫拄無簽名,只有套件會有簽名。
如果佇pamac出現簽名的錯誤,請試試下面的指令:
```bash
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

##### 20240330
xz 5.6.1-2

##### 20240404
kernel-6.8.3

##### 20240405
kernel-6.8.4

##### 20240411
kernel-6.8.5

##### 20240418
kernel-6.8.7

##### 20240429
kernel-6.8.8

##### 20240503
kernel-6.8.9

##### 20240515
kernel-6.9.0

##### 20240520
kernel-6.9.1

##### 20240527
kernel-6.9.2


----
佇Linux作業系統會使用的影像編輯軟體推薦:

[DaVinci Resolve 18 | Blackmagic Design](https://www.blackmagicdesign.com/products/davinciresolve)
免費版本已經夠用,使用起來毋是問題。
如果用付錢的Studio版本,會有更多實用的功能。

[ShotCut](https://shotcut.org/)

----
其他推薦的作業系統:  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE Leap Micro](https://get.opensuse.org/ja/leapmicro/)  

[BigLinux](https://www.biglinux.com.br/)

----
Manjaro repository鏡像站試運轉中
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
### 歡迎大家支持這項活動。
[Square](https://square.link/u/fZd2BXjR)  
[Paypal](https://paypal.me/phoepsilonix)  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
