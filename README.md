# [Manjaro Linux JP](https://osdn.net/projects/manjaro-jp/)

## [Manjaro Linux](https://manjaro.org/) の日本語対応
　ライブ環境も含めたデフォルトでの日本語入力および日本語表示に対応します。
[kernel-5.19系](https://kernel.org/)。

公式に合わせて、GNOME、KDE、Xfceの３種類を用意する予定です。
配布ファイルはISOと一部パッケージファイルです。
USBメモリなどから起動してください。 
USBメモリからの起動は、[Ventoy](https://ventoy.net/)を使うと楽かもしれません。
Ventoyの導入時に最初のパーティションをext4でフォーマットし直すのがお勧めです。

### 主な特徴
Linuxカーネルは、なるべく最新のものを採用します。
またカーネルのビルドにはclangを用います。
日本語入力(fcitx5-mozc)、日本語フォントを標準インストールします。
標準ブラウザとして[Vivaldi](https://vivaldi.com/)を採用します。
オフィスソフトとして[libreoffice-fresh](https://ja.libreoffice.org)を標準インストールします。

ライブ環境＆インストール用のISOを下記の配布先で公開しています。
よかったら、お試しください。

##### 注意事項
1. セキュアブートには非対応
対応していませんので、BIOSの設定でセキュアブートを無効にしてご利用ください。
（セキュアブート対応を望む場合、Ubuntuが早いと思います。Ubuntu Flavourでデスクトップ環境も複数提供されています。）

2. Vivaldiの動画コーデック不足のエラー表示がでる場合
動画の再生に必要なh.264コーデックが足りないというエラーがでる場合があるようです。
これはVivaldiのコンポーネントの更新に、時間がかかる場合があるためのようです。しばらくすると、自動更新されるかと思います。
また[Vivaldiのコンポーネント画面( vivaldi://components )](vivaldi://components)で手動更新も可能です。

3. 起動メニューが出ない場合
/etc/default/grubを修正して、update-grubを実行することで、メニュー表示が可能です。修正点は、GRUB_TIMEOUT_STYLEをhiddenからmenuに変更します。
その後、管理者権限でupdate-grubを実行すれば、次回の起動時からメニュー表示がでます。ファイルシステムがbtrfsの場合、スナップショットからの起動なども選択できるようになります。
GRUB_TIMEOUT_STYLE=menu に変更します。
TIMEOUTも適当な秒数を設定してください。
```sh
sudo nano /etc/default/grub
```

その後、次のコマンド実行です。
```sh
sudo update-grub
```

---
### 配布場所
[<img src="https://osdn.net/sflogo.php?group_id=14185&type=1" width="180">](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[<img src="http://sourceforge.net/sflogo.php?group_id=66882&type=5" width="180">](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[<img src="https://s0.teraboxcdn.com/fe-opera-static/node-static-v4/fe-webv4-main/img/logo.4e10d647.png" width="180">](https://terabox.com/s/19YM2KYCFY1sPaIXz_W-i-A) | [Manjaro-Linux-jp at Terabox](https://terabox.com/s/19YM2KYCFY1sPaIXz_W-i-A)  
[<img src="https://mega.nz/favicon.ico">](https://mega.nz/folder/5eMXlJaY#Dzp2PKdRgj0A6IQJsDv1Ew) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/5eMXlJaY#Dzp2PKdRgj0A6IQJsDv1Ew)

貴重な、ストレージをありがとうございます。
上記、３箇所にて配布しています。

---
### 備忘録
##### manjaro-tools-isoの変更箇所
1. buildisoに用いるパッケージの取得先をmirrorlistの先頭行を標準にしています。
デフォルトではミラーリストを読み込まず、EUのサーバーが使われる。
2. 自分が用意したパッケージを優先的にISOに含めるために、user-repos.confで指定したレポジトリの順位を優先させています。主にkernelの最新版を含めるためです。

### 更新履歴
<details><summary>これまでの歩み</summary>

##### 20220401
kernel-5.17.1 (clangビルド)
linux517-broadcom-wl,linux517-zfsパッケージもビルドして追加しました。
broadcom-wl-dkmsパッケージの修正内容などは、[gitlab](https://gitlab.com/phoepsilonix/manjaro-jp)の[Packagesフォルダ](https://gitlab.com/phoepsilonix/manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms)をご参照ください。

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
ISOには含まれませんが、nginx-quicパッケージなどをmanjaro-jpリポジトリに追加しました。
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
</details>

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


---
参考までに、追記。
LinuxをインストールしたPCがあれば、非公式？な(公式サポートがない)ChromeOSとのデュアルブート環境も作れるみたいです。ある程度知識のある方向けです。
興味がある方は、[こちら](https://github.com/sebanc/brunch/blob/master/install-with-linux.md)をご参考にしてください。

---
ローリングリリースが特徴のArchLinux系では、[Garuda Linux](https://garudalinux.org)も良さそうです。

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
(GPG signing public key:536487F1470D7187) <phoepsilonix あっと gmail どっと com>
[revolut](https://revolut.me/phoepsilonix)
[Paypal](https://paypal.me/phoepsilonix)
Bitcoin
15wwyVLTCtd1i4tuArwAcsCYPb2YBFH1CB
Ethreum
0x680932c238653da1d9d0950153c8a2b9d8f76a3e
