# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Unterstützung der japanischen Sprache für [Manjaro Linux](https://manjaro.org/)
　Unterstützt standardmäßig japanische Eingabe und Anzeige, einschließlich Live-Umgebungen.  
[Kernel-6.4-Serie](https://kernel.org/).

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
Wir haben das Paket pacman-static standardmäßig installiert. Bitte verwenden Sie dieses, wenn Paketaktualisierungen aufgrund von Bibliotheksinkonsistenzen schwierig werden.  

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
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![Google Drive](./Google_Drive_icon.svg)](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing) | [Manjaro-Linux-jp at Google Drive](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing)
[!<img src="data:image/png;base64,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" width="180">](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg) | [Manjaro-Linux-jp at Terabox](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg)  

Vielen Dank für die wertvolle Speicherung.  
Er wird an den drei oben genannten Orten verteilt.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), wo Sie Dateien mit einer Größe von 4G oder mehr hochladen können.

Wenn Sie von MEGA Storage mit der Befehlszeile herunterladen möchten, ist megatools nützlich.
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

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

* Wir haben vorübergehend ein Paket veröffentlicht, das nicht vollständig auf seine Funktionsfähigkeit getestet wurde.  
Bitte versuchen Sie, das von der offiziellen Manjaro-Distribution verteilte Paket mit dem folgenden Befehl neu zu installieren.
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
Ich habe ein Paket vorbereitet, um den manjaro-jp Signaturschlüssel zu installieren.  
Wenn ein Fehler aufgrund des manjaro-jp Signaturschlüssels auftritt, versuchen Sie bitte den folgenden Befehl zur Behebung.  
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
Wenn Software hinzugefügt und entfernt wird (pamac update), tritt ein Problem auf, während die Signaturdatei im Repository der signierten Datenbank aktualisiert wird.  
Um dieses Problem zu lösen, habe ich das pacman-Paket fein abgestimmt.  

##### 20230731
* Ich habe es so eingerichtet, dass die Signaturschlüsseldatei von manjaro_jp in der Installationsumgebung geladen wird.(calamares)

Ich glaube, dass durch die Korrektur des pacman-Pakets, die ich zuvor vorgenommen habe, und die Beseitigung der Unstimmigkeiten bei den Signaturschlüsseln, die Fehler vermutlich nicht mehr auftreten werden.  
Sollten dennoch Fehler auftreten, versuchen Sie bitte die folgenden Schritte.  

Initialisieren Sie die Signaturschlüsseldatenbank.
```
sudo pacman-key --init
sudo pacman-key --populate
```

Paketinformationen werden neu geladen.
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* Es wurde ein Problem in [Software hinzufügen/entfernen] behoben, bei dem Paketinformationen beschädigt waren und nach einer Update-Prüfung falsch beendet wurden. (pamac)  
* Bei der Suche nach installierten Paketen in [Software hinzufügen/entfernen] werden nun Flatpak- und Snap-Anwendungen in die Suche einbezogen. (libpamac)  

kernel-6.4.8


---
Andere empfohlene Betriebssysteme  
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
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix at phoepsilonix dot love>  

---
### Ihre Unterstützung für diese Aktivität ist sehr willkommen.  
[ofuse](https://ofuse.me/phoepsilonix)
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
