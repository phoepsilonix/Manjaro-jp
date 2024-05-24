# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) とは
[Manjaro Linux](https://manjaro.org)はx86_64系またはarm系プロセッサーのパソコンで動くLinux OSです。  

インターネットのサイトを閲覧するためのブラウザや表計算などのオフィス向けソフト、映像編集ソフトなど、いろんなソフトが動きます。  

Manjaro-jpは、標準で日本語環境を整えることを目指して、いろいろと調整しています。  
USBディスクなどから、起動するライブISO環境兼インストーラーを用意しています。  
もしよかったら、お試しください。  

Linuxには、いろんなディストリビューションといわれるものがありますが、プログラムのソースが公開されているものが多く、また互換性を保つ努力が継続されています。  
またディストリビューションを超えて、アプリケーションを配布する仕組みとして、[Flatpak](https://flatpak.org/)と[Snaps](https://snapcraft.io/about)といった仕組みが作られてきました。Manjaro LinuxもFlatpakとSnapsにも対応していますので、他のLinuxディストリビューションと同じように、いろんなアプリケーションが動作可能です。  
多くのディストリビューションが存在するのは、デスクトップ環境の差異だったり、OSの更新作業のための保守部分やセキュリティ対策をどうするか、といった部分で、ポリシーだったり、やり方が異なるからです。  
ただ、基本的には同じアプリケーションが動作する場合がほとんどなので、一般のユーザーには、あまり関係ないことです。自分が使いやすい、ユーザーが多そうなものを選べば大丈夫だと思います。  

なおManjaro LinuxはArm系プロセッサーにも対応していますが、その日本語対応は、サーバーもパソコンも手元に持っていないため、検証が難しいので、未対応です。x86_64系のパソコンでご利用ください。  

----
## [Manjaro Linux](https://manjaro.org/) の日本語対応
　ライブ環境も含めたデフォルトでの日本語入力および日本語表示に対応します。  
[kernel-6.9系](https://kernel.org/)。

公式に合わせて、KDE、Xfce、GNOMEの３種類を用意する予定です。  
配布ファイルはISOと一部パッケージファイルです。  
USBメモリなどから起動してください。   
USBメモリからの起動は、[Ventoy](https://ventoy.net/)を使うと楽かもしれません。  
Ventoyの導入時に最初のパーティションをext4でフォーマットし直すのがお勧めです。

----
### Ventoyのインストールについて
Manjaro LinuxでventoyをUSBにインストールする場合の手順
```bash
sudo pacman -S ventoy
ventoygui
```
Linux全般  
ダウンロードコマンドがaria2の場合の例
```bash
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-linux.tar.gz
tar xf ventoy-1.0.97-linux.tar.gz
cd ventoy-1.0.97
./VentoyGUI.x86_64 
```

Windowsの場合  
ブラウザなどで[Ventoy](https://github.com/ventoy/Ventoy/releases/)を[ダウンロード](https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-windows.zip)します。
ダウンロードしたzipファイルを開いて、ventoy2disk.exeを実行しましょう。

----
### Manjaro-JPの主な特徴
Linuxカーネルは、なるべく最新のものを採用します。  
またカーネルのビルドにはclangを用います。  
日本語入力(Mozc)、日本語フォントを標準インストールします。  
標準ブラウザとして、[Floorp](https://floorp.ablaze.one/)を採用します。  
オフィスソフトとして[LibreOffice](https://ja.libreoffice.org)を標準インストールします。  
pacman-staticパッケージを標準導入しています。ライブラリの不整合によって、パッケージ更新が困難になった場合に、ご利用ください。  
```bash
sudo pacman-static -Syyu
```

##### 注意事項
1. セキュアブートには非対応  
インストーラーが対応していませんので、BIOSの設定でセキュアブートを無効にしてご利用ください。  
インストール後、対応することは可能です。  
[Manjaro Linuxでセキュアブート(secure boot)(shim-singed)](https://zenn.dev/phoepsilonix/articles/90ad66114a4982)  
[Manjaro Linuxでセキュアブート(secure boot)(efitools)](https://zenn.dev/phoepsilonix/articles/5e6488bb46f37e)  
（セキュアブート対応を望む場合、[Ubuntu][Ubuntu]は簡単です。[Ubuntu flavours][Ubuntu flavours]でデスクトップ環境も複数提供されています。日本語対応も簡単です。）  

[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. ISOから起動したライブ環境ではsnapアプリケーションのインストールは停止されています。  
インストール後の環境では有効になりますが、どうしても試したい場合には手動で有効化できます。
```bash
sudo systemctl start snapd.service
```

3. インストール途中でインストーラー画面が消える場合には  
swapパーティションを手動で設定することで、回避できる場合が多いです。  
swapパーティションを/dev/sdXとした場合、次のようなコマンドで手動でswapを有効にしてみてください。
```bash
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```bash
# swapが有効ではない場合、lsblkでデバイスを調べて、swapパーティションを有効にします。
[[ $(swapon --show) == "" ]] &&  SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```

また次のコマンドで、OOM killer（強制終了）の対象外を指定しておきましょう。
```bash
pidof -xw calamares_polkit | xargs -n1 sudo choom -n -1000 -p
```

4. 一部アプリで日本語入力ができない場合  
古い設定が残っていて、`gtk-im-module`になにか設定されている場合、一部アプリで入力できないケースがあるようです。
```bash
gsettings get org.gnome.desktop.interface gtk-im-module
```
このコマンドで`gtk-im-context-simple`などが表示されたら、次のコマンドで設定を消しましょう。
```bash
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

5. Manjaro公式とのkernelの違い  
kererl-6.6系がManjaro公式のisoでは採用されていました。最新のManjaroはkernel-6.9系に移行したようです。  
ここで配布しているisoは、なるべく新しいkernelを採用しています。現在はkernel-6.9系です。  
kernelおよびkernelモジュールのビルドにgccではなくclangを使用しています。  
またkernelのrust対応も有効にしています。  
Manjaro公式のkernelを利用したい場合には、下記コマンドのようにレポジトリcoreを指定してインストールしてください。
```sh
sudo pacman -S core/linux66 core/linux66-headers
```
```sh
sudo pacman -S core/linux69 core/linux69-headers
```

----
### 配布場所
ライブ環境＆インストール用のISOを下記の配布先で公開しています。  
よかったら、お試しください。

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

貴重な、ストレージをありがとうございます。  
上記にて配布しています。

Teraboxでは、ファイルサイズ4G以上は、コストがかかるので、分割形式でアップロードしています。ダウンロードした後に、一つのファイルにまとめてから、ご利用ください。Mac,iosではkeka,Windowsでは7-zipが操作がわかりやすいようです。  

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0)は、ファイルサイズ4G以上のものもアップロードできるので、お勧めです。  
[pCloud](https://partner.pcloud.com/r/119318)も4G以上のサイズも大丈夫です。生涯買い切りタイプのプランがあるクラウドストレージです。

コマンドラインで、MEGA Storageからダウンロードする場合、megatoolsが便利です。
```bash
sudo pacman -S megatools
```

```bash
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
## 参考：導入ガイド
[Manjaro Linux 最初の一歩](https://zenn.dev/phoepsilonix/articles/5be4f3e3d78af7)  
[Manjaro Linux 日本語ライブ環境](https://zenn.dev/phoepsilonix/articles/a48758b4812127)  

----
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
ソフトウェアの追加と削除(pamac update)を実行すると、署名付きのデータベースを提供しているレポジトリで、署名ファイルの更新がうまく動作しない問題がありました。  
その解決のためpacmanパッケージを微調整しました。

##### 20230731
* インストール先の環境に、manjaro_jpの署名鍵ファイルを読み込むようにしました。(calamares)  

先に行ったpacmanパッケージの修正とあわせて、署名鍵の不整合によるエラーが起きるケースがなくなったのでは、と思います。  
それでも、もしもエラーが起きる場合には、次の手順を試してみてください。  

署名鍵データベースの初期化
```bash
sudo pacman-key --init
sudo pacman-key --populate
```

パッケージ情報を再読込
```bash
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* [ソフトウェアの追加と削除]において、更新チェックのあと、パッケージ情報が壊れて不正終了する問題を修正しました。(pamac) 
* [ソフトウェアの追加と削除]において、インストール済みのパッケージを検索する場合に、flatpak、snapアプリケーションも検索対象に含めるようにしました(libpamac) 
* kernel-6.4.8

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

manjaro-jpのデータベースの署名をなくしました。パッケージのみ署名ありにします。  
pamacで署名のエラーが発生する場合には、次のコマンドを試してください。

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


----
###### おすすめ映像編集ソフト  
Linux系OSで動きます。  
[DaVinci Resolve 18 | Blackmagic Design](https://www.blackmagicdesign.com/products/davinciresolve)  
無料版でも十分、使えます。  
有料版のStudioだと、より便利な機能が使えます。  

[ShotCut](https://shotcut.org/)

----
その他のおすすめOS  
[Ubuntu][Ubuntu]  
[Ubuntu flavours | Ubuntu][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE Leap Micro](https://get.opensuse.org/ja/leapmicro/)  

[BigLinux](https://www.biglinux.com.br/)

----
[Manjaroレポジトリミラー試験稼働中](https://mirror.phoepsilonix.love/manjaro/)
```
## Country : Japan
Server = https://mirror.phoepsilonix.love/manjaro/stable/$repo/$arch
```

----
```
[manjaro-jp]
SigLevel = PackageRequired
Server = https://manjaro-jp.phoepsilonix.love/manjaro-jp/
#Server = https://manjaro-jp.sourceforge.io/manjaro-jp/
```

----
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix あっと phoepsilonix どっと love>  

----
### この活動へのご支援を歓迎します。  
[Square](https://square.link/u/fZd2BXjR)  
[Paypal](https://paypal.me/phoepsilonix)  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
