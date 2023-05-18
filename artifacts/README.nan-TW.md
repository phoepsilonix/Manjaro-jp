# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) 日語支援

默認支援日語輸入和日語顯示，包括實時環境。  
kernel-6.2.x（穩定）。

按照公式，我們計劃準備三種類型：KDE、Xfce、GNOME。  
分發檔是 ISO 和一些包檔。  
從U盤啟動。  
使用 Ventoy 從 U 盤啟動可能更容易。  
建議在部署 Ventoy 時用 ext4 重新格式化第一個分區。  

### 主要特點

Linux kernel應該盡可能是最新的。  
此外，clang 用於構建kernel。  
日語輸入(fcitx5-mozc)，日語字體作為標準安裝。  
採用flatpak Firefox或Floorp作為標準瀏覽器。  
將LibreOffice的flatpak版本作為辦公軟體作為標準安裝。  

實時環境和安裝 ISO 可在以下分發目標獲得。  
如果您願意，請嘗試一下。  

##### 注意事項
1. 不支援安全啟動  
它不受支援，因此請在BIOS設置中禁用安全啟動。  
（如果你想要安全啟動支援，Ubuntu 更快。 [烏班圖口味](https://ubuntu.com/desktop/flavours) 還提供多個桌面環境。）

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

##### 附加說明： 2023-02-11  
[Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/) 在最新版本的（2023-02-11-）中，增加了上述措施。  
我們還修改了安裝程式，以添加一個進程，以便在安裝期間啟用交換分區。
魷魚也有[反饋](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe)。

---
### 分發位置
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A)

感謝您的寶貴存儲空間。  
分佈於以上三地。

[超級存儲](https://mega.nz/storage/aff=gVLIePn4Hy0) 建議使用 ，因為它也可以上傳大於 4G 的檔。

---
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
</details>

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


---
供參考，後記。  
如果你有一台安裝了Linux的PC，非官方的？ 似乎您還可以使用ChromeOS（沒有官方支援）創建雙啟動環境。 它是為那些有一定知識的人準備的。  
如果您有興趣，請參閱[這裡](https://github.com/sebanc/brunch/blob/master/install-with-linux.md)。（[日文翻譯](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82)）

---
在具有滾動版本的Arch Linux系列中，[Garuda Linux](https://garudalinux.org) 看起來也不錯。

---
其他推薦的操作系統  
[Endless OS | Endless Computers](https://endlessos.com/)  
[Fedora Kinoite](https://kinoite.fedoraproject.org/ja/)  
[Fedora Silverblue](https://getfedora.org/ja/silverblue/)  

---
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://osdn.net/projects/manjaro-jp/storage/manjaro-jp/
```
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://manjaro-jp.osdn.jp/manjaro-jp/
```
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
[manjaro-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
(GPG signing public key:536487F1470D7187) <phoepsilonix あっと gmail どっと com>  

[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  
[Patreon](https://patreon.com/user?u=87853674&utm_medium=clipboard_copy&utm_source=copyLink&utm_campaign=creatorshare_creator&utm_content=join_link)  
[revolut](https://revolut.me/phoepsilonix)  
[Paypal](https://paypal.me/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
