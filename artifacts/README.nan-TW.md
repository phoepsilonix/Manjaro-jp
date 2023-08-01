# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) 日語支援

默認支援日語輸入和日語顯示，包括即時ISO(現場ISO)。  
[kernel-6.4.x](https://kernel.org/).

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
我們已預設安裝了pacman-static套件。如果因為函式庫的不合一致，導致套件更新變得困難，請使用它。

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
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[<img src="data:image/png;base64,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" width="180">](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg) | [Manjaro-Linux-jp at Terabox](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg)  
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  

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


---
供參考，後記。  
如果你有一台安裝了Linux的PC，非官方的？ 似乎您還可以使用ChromeOS（沒有官方支援）創建雙啟動環境。 它是為那些有一定知識的人準備的。  
如果您有興趣，請參閱[這裡](https://github.com/sebanc/brunch/blob/master/install-with-linux.md)。（[日文翻譯](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82)）

---
其他推薦的操作系統  
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
### 對於這個活動的支持，我們非常歡迎。
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
