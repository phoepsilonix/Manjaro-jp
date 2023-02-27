# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Unterstützung der japanischen Sprache für [Manjaro Linux](https://manjaro.org/)
　Unterstützt standardmäßig japanische Eingabe und Anzeige, einschließlich Live-Umgebungen.  
[Kernel-6.2-Serie(mainline)](https://kernel.org/).

KDE, Xfce und GNOME werden für den offiziellen Gebrauch verfügbar sein.  
Die Distributionsdateien sind ISO und einige Paketdateien.  
Booten Sie von einem USB-Speicherstick oder ähnlichem.   
Das Booten von einem USB-Speicherstick kann mit [Ventoy](https://ventoy.net/) einfacher sein.  
Es wird empfohlen, die erste Partition bei der Installation von Ventoy mit ext4 neu zu formatieren.

### Hauptmerkmale.
Der Linux-Kernel ist so aktuell wie möglich.  
Der Kernel wird mit clang gebaut.  
Japanische Eingabe (fcitx5-mozc) und japanische Schriftarten sind standardmäßig installiert.  
Flatpak-Versionen von [Firefox](https://www.mozilla.org/ja/firefox/browsers/) oder [Floorp](https://floorp.ablaze.one/) werden als Standardbrowser verwendet.  
Die Flatpak-Version [LibreOffice](https://ja.libreoffice.org) wird als Standard-Office-Software installiert.

Live-Umgebung & Installations-ISOs sind auf den folgenden Distributionsseiten verfügbar.  
Sie können sie ausprobieren, wenn Sie möchten.

##### Hinweise.
1. Secure Boot nicht unterstützt  
Nicht unterstützt, daher bitte Secure Boot in den BIOS-Einstellungen deaktivieren.  
(Wenn Sie Secure-Boot-Unterstützung wünschen, ist Ubuntu der schnellste Weg. Verschiedene Desktop-Umgebungen sind auch unter [Ubuntu flavours](https://ubuntu.com/desktop/flavours) verfügbar).

2. Wenn der Bildschirm des Installationsprogramms während der Installation verschwindet  
Oft lässt sich dies vermeiden, indem man die Swap-Partition manuell einstellt.  
Wenn die Swap-Partition /dev/sdX ist, versuchen Sie, die Swap-Partition manuell mit dem folgenden Befehl zu aktivieren.
```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# Wenn Swap nicht aktiviert ist, verwenden Sie lsblk, um das Gerät zu untersuchen und die Swap-Partition zu aktivieren.
[[ $(swapon --show) == "" ]] && SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```

Verwenden Sie auch den folgenden Befehl, um anzugeben, dass Sie nicht dem OOM-Killer (erzwungene Beendigung) unterliegen wollen.
```
pidof -xw Xwayland calamares_polkit | xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

##### Hinzugefügt: 2023-02-11  
In der neuesten Version (vom 2023-02-11) von [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/) sind die oben genannten Maßnahmen hinzugefügt worden.  
Außerdem wurde das Installationsprogramm geändert, um einen Prozess zur Aktivierung der Swap-Partition während der Installation hinzuzufügen.
[Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe) hat bereits eine Rückmeldung erhalten.

##### Hinzugefügt: 2023-02-27  
Die obigen Rückmeldungen deuten darauf hin, dass Swap je nach Konfiguration der Partition möglicherweise nicht aktiviert ist.  
Daher wurde als zusätzliche Maßnahme die Verwendung von zram-generator hinzugefügt.

---
### Vertriebsort.
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A)

Vielen Dank für die wertvolle Speicherung.  
Er wird an den drei oben genannten Orten verteilt.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), wo Sie Dateien mit einer Größe von 4G oder mehr hochladen können.

---
### Memorandum
##### manjaro-tools-iso Änderungen
1. Die erste Zeile der Mirrorliste wird als Standard verwendet, um die für buildiso verwendeten Pakete zu erhalten.  
Standardmäßig wird die Spiegelliste nicht geladen und der EU-Server wird verwendet.
2. Priorisierung der Reihenfolge der Repositories, die in user-repos.conf angegeben sind, um die Pakete, die Sie vorbereitet haben, in das ISO aufzunehmen.  
Dies dient hauptsächlich dazu, die neuesten Versionen des Kernels einzubinden.

### Historie der Aktualisierungen
<details><summary>Vergangenheit</summary>.

##### 20220401
kernel-5.17.1 (clang build)  
linux517-broadcom-wl,linux517-zfs Pakete ebenfalls gebaut und hinzugefügt.  
Änderungen am Paket broadcom-wl-dkms und andere Informationen können im [Packages folder](https://gitlab.com/phoepsilonix/) in [gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp) gefunden werden. Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms).
Siehe auch.

##### 20220408
Der einzige Standardbrowser ist [Vivaldi] (https://vivaldi.com/).  
Natürlich können Sie auch zu anderen Browsern wechseln.  
Die GRUB-Standardwerte beim Booten in der Live-Umgebung wurden für Japan geändert.

##### 20220411
Ein Fehler in der Paketaktualisierung wurde behoben.  
Hinzufügen von japanischen Schriftarten.  
Morisawa BIZ UD, [veröffentlicht unter SIL OFL Lizenz](https://www.morisawa.co.jp/about/news/6706) von [Dear Morisawa Inc.](https://www.morisawa.co.jp/). Morisawa BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho) und [Morisawa BIZ UD Gothic](https://github.com/googlefonts/) Schriftarten. morisawa-biz-ud-gothic) sind vorinstalliert.  
Die Schriftarten sind so enthalten, wie sie auf Github veröffentlicht sind. Es enthält auch die Lizenzdatei, etc. (Ich habe es auch selbst gebaut und keine Unterschiede in den Binärdateien gefunden).
Weitere Informationen finden Sie auf der Originalseite oben oder in der Github-Dokumentation.  
Unterstützung der Schriftart [Morisawa BIZ+] (https://www.morisawa.co.jp/products/fonts/bizplus/lineup/).

##### 20220413
Morisawa BIZ UD-Schriftartenpaket, registriert bei der AUR.

##### 20220414
Aktualisiert auf Kernel-5.17.3.

##### 20220421
Aktualisiert auf Kernel-5.17.4.

##### 20220422
Japanische Eingabe auf fcitx5-mozc geändert.

##### 20220424
Japanische Tastatur und Mozc als Standard aktiviert.

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
Die Desktop-Umgebung GNOME wurde auf GNOME42 aktualisiert.

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
Aktualisierte nvidia-Treiberversion auf 515.43.04.
Kernel-5.18-Serie hinzugefügt.

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
Änderungen im Zusammenhang mit Bürosoftware  
Die Auswahl von Office-Software im Installationsprogramm wurde entfernt.  
Hauptsächlich um den Platzbedarf zu reduzieren, wurde die Auswahl der Bürosoftware im Installationsprogramm entfernt und die standardmäßig installierte Bürosoftware wurde von onlyoffice-desktopeditor auf libreoffice-fresh geändert.

##### 20220611
kernel-5.17.14  
kernel-5.18.3  
Aktualisierte nvidia-Treiberversion auf 515.48.07.  
Virtualbox-host-dkms wurde korrigiert, um unter linux518 zu bauen.  
nginx-quic-Paket und andere Pakete zum manjaro-jp-Repository hinzugefügt, obwohl nicht im ISO enthalten.  
Das manjaro-jp Repository wurde in die pacman.conf aufgenommen.

##### 20220614
Fehlerbehebungen im Installer.  
In der GNOME-Version wurde der Editor von gedit auf gnome-text-editor umgestellt.

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6  
Audio-bezogenes manjaro-pulse auf manjaro-pipewire umgestellt.

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8  
nvidia-utils 515.57

##### 20220703
kernel-5.18.9

##### 20220706
Aktiviert cups-browsed.  
ipp-usb-Paket hinzugefügt.

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
Standard-Browser geändert auf [Floorp](https://floorp.ablaze.one/).

##### 20221105
kernel-6.0.7  
mkinitcpio-32-2

##### 20221112
Flatpak-Version [Firefox](https://www.mozilla.org/ja/firefox/browsers/) oder [Floorp](https://floorp.ablaze.one/) als Standardbrowser.  
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10  
LibreOffice wurde auf die Flatpak-Version umgestellt.  
Die Standardtastatur von fcitx5 wurde auf Japanisch (Kana 86) umgestellt.  
Die Standardschriftart von gnome-terminal wurde auf FirgeNerd Console geändert.  
Die folgenden Schriftarten wurden vorinstalliert.  
[Firge: Programmierschriftart Firge (Firge), eine Kombination aus Fira Mono und Gen Shin Gothic](https://github.com/yuru7/Firge)  
[HackGen: Programmierschriftart, die Hack und Genju Gothic Hakugen (HackGen) kombiniert](https://github.com/yuru7/HackGen)

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
manjaro-Veröffentlichung 22.0.2  
kernel-6.1.9
</Details>

##### 20230210
kernel-6.1.11  
nvidia-utils 525.89.02  
Repository-URL für Manjaro-jp geändert.  
(Von OSDN zu OSDN Web. Kann vorübergehend sein.)  
ISO-Dateien werden auf [SourceForge](https://sourceforge.net/projects/manjaro-jp/) verteilt.  
Einige Änderungen am Calamares-Installationsprogramm.  
(Verringert die Anzahl der Fälle, in denen das Installationsprogramm unter hoher Last zum Abbruch gezwungen wird.)   

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

---
Zusätzliche Informationen als Referenz.  
Wenn Sie einen PC mit installiertem Linux haben, können Sie eine inoffizielle? Wenn Sie einen PC mit installiertem Linux haben, können Sie eine Dual-Boot-Umgebung mit inoffiziellem (keine offizielle Unterstützung) ChromeOS erstellen. Dies ist für Leute mit einigen Kenntnissen.  
Wenn Sie interessiert sind, lesen Sie bitte [hier](https://github.com/sebanc/brunch/blob/master/install-with-linux.md). ([Japanisch](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82))

---
In der ArchLinux-Familie, die rollierende Veröffentlichungen anbietet, sieht [Garuda Linux](https://garudalinux.org) ebenfalls gut aus.

---
Andere empfohlene Betriebssysteme  
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

[Patreon](https://patreon.com/user?u=87853674&utm_medium=clipboard_copy&utm_source=copyLink&utm_campaign=creatorshare_creator&utm_content=join_link)  
[revolut](https://revolut.me/phoepsilonix)  
[Paypal](https://paypal.me/phoepsilonix)  

BTC  
```15wwyVLTCtd1i4tuArwAcsCYPb2YBFH1CB```

ETH(main net)  
```0x6d814317881ee2ea617fa6989f255f19b949eb60```

USDT(ERC20)  
```0x7e92844d51094eb164a7f4444524b55c31748546```

