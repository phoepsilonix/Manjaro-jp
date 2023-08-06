# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) の日本語対応
　ライブ環境も含めたデフォルトでの日本語入力および日本語表示に対応します。  
[kernel-6.4系](https://kernel.org/)。

公式に合わせて、KDE、Xfce、GNOMEの３種類を用意する予定です。  
配布ファイルはISOと一部パッケージファイルです。  
USBメモリなどから起動してください。   
USBメモリからの起動は、[Ventoy](https://ventoy.net/)を使うと楽かもしれません。  
Ventoyの導入時に最初のパーティションをext4でフォーマットし直すのがお勧めです。

### 主な特徴
Linuxカーネルは、なるべく最新のものを採用します。  
またカーネルのビルドにはclangを用います。  
日本語入力(fcitx5-mozc)、日本語フォントを標準インストールします。  
標準ブラウザとして、flatpak版[Firefox](https://www.mozilla.org/ja/firefox/browsers/)または[Floorp](https://floorp.ablaze.one/)を採用します。  
オフィスソフトとしてflatpak版[LibreOffice](https://ja.libreoffice.org)を標準インストールします。  
pacman-staticパッケージを標準導入しています。ライブラリの不整合によって、パッケージ更新が困難になった場合に、ご利用ください

ライブ環境＆インストール用のISOを下記の配布先で公開しています。  
よかったら、お試しください。

##### 注意事項
1. セキュアブートには非対応  
対応していませんので、BIOSの設定でセキュアブートを無効にしてご利用ください。  
（セキュアブート対応を望む場合、Ubuntuが早いと思います。[Ubuntu flavours](https://ubuntu.com/desktop/flavours)でデスクトップ環境も複数提供されています。）

2. インストール途中でインストーラー画面が消える場合には  
swapパーティションを手動で設定することで、回避できる場合が多いです。  
swapパーティションを/dev/sdXとした場合、次のようなコマンドで手動でswapを有効にしてみてください。
```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# swapが有効ではない場合、lsblkでデバイスを調べて、swapパーティションを有効にします。
[[ $(swapon --show) == "" ]] &&  SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```

また次のコマンドで、OOM killer（強制終了）の対象外を指定しておきましょう。
```
pidof -xw Xwayland calamares_polkit | xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

##### 追記: 2023-02-11  
[Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/)の最新版(2023-02-11〜)では、上記の対策が追加されています。  
またインストーラーに手を加えて、インストール時にswapパーティションを有効にする処理を追加しました。
Calamaresにも、[フィードバック済み](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe)です。

##### 追記: 2023-02-27  
上記のフィードバックでは、パーティションの構成方法によって、swapが有効化されない場合があります。  
そのため追加の対策として、zram-generatorの活用を追加しました。

---
### 配布場所
[![MEGA](https://manjaro-jp.phoepsilonix.love/img/mega-icon.svg)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [<svg id = "MANJARO-QR" viewBox="0 0 128px 128px"><image id = "MANJARO-QR" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/qr-manjaro-jp-mega.png"/><image id = "MANJARO-ICON" x="48" y="48" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/mega-icon.svg"/></svg>](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)   
---|---|---  
[![SourceForge](https://manjaro-jp.phoepsilonix.love/img/sf_logo.png)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/) | [<svg id = "MANJARO-QR" viewBox="0 0 128px 128px"><image id = "MANJARO-QR" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/qr-manjaro-jp-sourceforge.png"/><image id = "MANJARO-ICON" x="48" y="48" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/sourceforge-icon.svg"/></svg>](https://sourceforge.net/projects/manjaro-jp/)
[![Google Drive](https://manjaro-jp.phoepsilonix.love/img/Google_Drive_icon.svg)](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing) | [Manjaro-Linux-jp at Google Drive](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing) | [<svg id = "MANJARO-QR" viewBox="0 0 128px 128px"><image id = "MANJARO-QR" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/qr-manjaro-jp-google.png"/><image id = "MANJARO-ICON" x="48" y="48" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/Google_Drive_icon.svg"/></svg>](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing)
[![Terabox](https://manjaro-jp.phoepsilonix.love/img/terabox_logo.svg)](https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag) | [Manjaro-Linux-jp at Terabox](https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag) | [<svg id = "MANJARO-QR" viewBox="0 0 128px 128px"><image id = "MANJARO-QR" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/qr-manjaro-jp-terabox.png"/><image id = "MANJARO-ICON" x="48" y="48" xlink:href = "https://manjaro-jp.phoepsilonix.love/img/terabox_logo.svg"/></svg>](https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag)

貴重な、ストレージをありがとうございます。  
上記にて配布しています。

Teraboxでは、ファイルサイズ4G以上は、コストがかかるので、分割形式でアップロードしています。ダウンロードした後に、一つのファイルにまとめてから、ご利用ください。  

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0)は、ファイルサイズ4G以上のものもアップロードできるので、お勧めです。

コマンドラインで、MEGA Storageからダウンロードする場合、megatoolsが便利です。
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

---
## 参考：導入ガイド
[Manjaro Linux 最初の一歩](https://zenn.dev/phoepsilonix/articles/5be4f3e3d78af7)

---
### 備忘録
##### manjaro-tools-isoの変更箇所
1. buildisoに用いるパッケージの取得先をmirrorlistの先頭行を標準にしています。  
デフォルトではミラーリストを読み込まず、EUのサーバーが使われる。
2. 自分が用意したパッケージを優先的にISOに含めるために、user-repos.confで指定したレポジトリの順位を優先させています。  
主にkernelの最新版を含めるためです。

### 更新履歴
<details><summary>これまでの歩み</summary>

##### 20220401
kernel-5.17.1 (clangビルド)  
linux517-broadcom-wl,linux517-zfsパッケージもビルドして追加しました。  
broadcom-wl-dkmsパッケージの修正内容などは、[gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp)の[Packagesフォルダ](https://gitlab.com/phoepsilonix/Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms)をご参照ください。

##### 20220408
標準のブラウザを[Vivaldi](https://vivaldi.com/)のみにしました。  
もちろん他のブラウザにも自由に変更できます。  
ライブ環境のブート時のGRUBの初期値を日本向けにしました。

##### 20220411
パッケージ更新の不具合修正。  
日本語フォントの追加。  
[Morisawa Inc. 様](https://www.morisawa.co.jp/)が[SIL OFLライセンスのもとに公開](https://www.morisawa.co.jp/about/news/6706)してくださったMorisawa BIZ UDフォントの[Morisawa BIZ UD明朝](https://github.com/googlefonts/morisawa-biz-ud-mincho)、[Morisawa BIZ UDゴシック](https://github.com/googlefonts/morisawa-biz-ud-gothic)をプリインストールしました。  
Githubで公開されているフォントをそのまま収録したものです。ライセンスファイルなども同梱しています。(自分でもビルドしましたが、バイナリに差異はありませんでした。)
詳しくは上記の本家サイトやGithubの文書をご確認ください。  
[Morisawa BIZ+ フォント](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/)を応援しましょう。

##### 20220413
AURにMorisawa BIZ UDフォントパッケージを登録しました。

##### 20220414
kernel-5.17.3 に更新しました。

##### 20220421
kernel-5.17.4に更新しました。

##### 20220422
日本語入力をfcitx5-mozcに変更しました。

##### 20220424
日本語キーボードとMozcを標準で有効にしました。

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
デスクトップ環境のGNOMEがGNOME42に更新されました。

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
nvidiaドライバのバージョンを515.43.04に更新。
kernel-5.18系を追加。

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
オフィスソフト関連の変更  
インストーラーでのオフィスソフトの選択をなくしました。  
主に容量を減らすために、インストーラーでのオフィスソフトの選択をなくし、標準インストールするオフィスソフトをonlyoffice-desktopeditorからlibreoffice-freshに変更しました。

##### 20220611
kernel-5.17.14  
kernel-5.18.3  
nvidiaドライバのバージョンを515.48.07に更新。  
virtualbox-host-dkmsをlinux518でビルドできるように修正。  
manjaro-jpリポジトリをpacman.confに含めました。

##### 20220614
インストーラーのバグ修正。  
GNOME版においてエディタをgeditからgnome-text-editorへ変更しました。

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6  
オーディオ関係のmanjaro-pulseをmanjaro-pipewireに切り替えました。

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8  
nvidia-utils 515.57

##### 20220703
kernel-5.18.9

##### 20220706
cups-browsedを有効にしました。  
ipp-usbパッケージを追加しました。

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
標準ブラウザを[Floorp](https://floorp.ablaze.one/)に変更しました。

##### 20221105
kernel-6.0.7  
mkinitcpio-32-2

##### 20221112
標準ブラウザとして、flatpak版[Firefox](https://www.mozilla.org/ja/firefox/browsers/)または[Floorp](https://floorp.ablaze.one/)を採用します。  
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10  
LibreOfficeをflatpak版に変更しました。  
fcitx5の初期設定のキーボードを日本語(かな 86)に変更しました。  
gnome-terminalの初期フォントをFirgeNerd Consoleに変更しました。  
下記フォントをプリインストールしました。  
[Firge: Fira Mono と源真ゴシックを合成したプログラミングフォント Firge (ファージ)](https://github.com/yuru7/Firge)  
[HackGen: Hack と源柔ゴシックを合成したプログラミングフォント 白源 (はくげん／HackGen)](https://github.com/yuru7/HackGen)

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
nvidia-utils 525.89.02  
Manjaro-jpのレポジトリURLを変更しました。  
（OSDNからOSDN Webへ。一時的なものになるかもしれません。）  
ISOファイルは、[SourceForge](https://sourceforge.net/projects/manjaro-jp/)で配布します。  
Calamaresインストーラーに若干手を加えました。  
（高負荷時にインストーラーが強制終了するケースを減らします。）   

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

* 一時的に動作検証が不十分なパッケージを公開してしまいました。  
お手数ですが、次のコマンドでManjaro公式が配布しているパッケージをインストールしなおしてみてください。
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

##### 20230628
kernel-6.4.0  
インストーラが起動しない不具合を修正し、再アップロードしました。

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
manjaro-jpの署名鍵をインストールするパッケージを用意しました。  
manjaro-jpの署名鍵が原因のエラーが発生した場合には、次のコマンドで対処してみてください。  
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
</details>

##### 20230729
ソフトウェアの追加と削除(pamac update)を実行すると、署名付きのデータベースを提供しているレポジトリで、署名ファイルの更新がうまく動作しない問題がありました。  
その解決のためpacmanパッケージを微調整しました。

##### 20230731
* インストール先の環境に、manjaro_jpの署名鍵ファイルを読み込むようにしました。(calamares)  

先に行ったpacmanパッケージの修正とあわせて、署名鍵の不整合によるエラーが起きるケースがなくなったのでは、と思います。  
それでも、もしもエラーが起きる場合には、次の手順を試してみてください。  

署名鍵データベースの初期化
```
sudo pacman-key --init
sudo pacman-key --populate
```

パッケージ情報を再読込
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* [ソフトウェアの追加と削除]において、更新チェックのあと、パッケージ情報が壊れて不正終了する問題を修正しました。(pamac) 
* [ソフトウェアの追加と削除]において、インストール済みのパッケージを検索する場合に、flatpak、snapアプリケーションも検索対象に含めるようにしました(libpamac) 

kernel-6.4.8


---
###### おすすめ映像編集ソフト  
Linux系OSで動きます。  
[DaVinci Resolve 18 | Blackmagic Design](https://www.blackmagicdesign.com/products/davinciresolve)  
無料版でも十分、使えます。  
有料版のStudioだと、より便利な機能が使えます。  

---
その他のおすすめOS  
[Endless OS | Endless Computers](https://endlessos.com/)  

---
[Manjaroレポジトリミラー試験稼働中](https://mirror.phoepsilonix.love/manjaro/)
```
## Country : Japan
Server = https://mirror.phoepsilonix.love/manjaro/stable/$repo/$arch
```

---
```
[manjaro-jp]
SigLevel = Required
Server = https://manjaro-jp.phoepsilonix.love/manjaro-jp/
#Server = https://manjaro-jp.sourceforge.io/manjaro-jp/
#Server = https://manjaro-jp.osdn.jp/manjaro-jp/
```

---
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix あっと phoepsilonix どっと love>  

---
### この活動へのご支援を歓迎します。  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
