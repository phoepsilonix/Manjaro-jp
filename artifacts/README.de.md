# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Unterstützung der japanischen Sprache für [Manjaro Linux](https://manjaro.org/)
　Unterstützt standardmäßig japanische Eingabe und Anzeige, einschließlich Live-Umgebungen.  
[Kernel-6.12 Serie](https://kernel.org/).

KDE, Xfce und GNOME werden für den offiziellen Gebrauch verfügbar sein.  
Die Distributionsdateien sind ISO und einige Paketdateien.  
Booten Sie von einem USB-Speicherstick oder ähnlichem.   
Das Booten von einem USB-Speicherstick kann mit [Ventoy](https://ventoy.net/) einfacher sein.  
Es wird empfohlen, die erste Partition bei der Installation von Ventoy mit ext4 neu zu formatieren.

----
### Über die Installation von Ventoy
Schritte zur Installation von ventoy auf einem USB-Laufwerk mit Manjaro Linux  
```bash
sudo pacman -S ventoy
ventoygui
```
Allgemeines Linux  
Beispiel für einen Download-Befehl mit aria2  
```bash
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.1.00/ventoy-1.1.00-linux.tar.gz
tar xf ventoy-1.1.00-linux.tar.gz
cd ventoy-1.1.00
./VentoyGUI.$(uname -m)
```
Windows  
Laden Sie [Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.1.00/ventoy-1.1.00-windows.zip) mit einem Browser oder etwas herunter.  
Öffnen Sie die heruntergeladene Zip-Datei und führen Sie ventoy2disk.exe aus.

----
### Hauptmerkmale.
Der Linux-Kernel ist so aktuell wie möglich.  
Der Kernel wird mit clang gebaut.  
Japanische Eingabe (fcitx5-mozc) und japanische Schriftarten sind standardmäßig installiert.  
[Floorp](https://floorp.ablaze.one/) werden als Standardbrowser verwendet.  
Wir haben das Paket pacman-static standardmäßig installiert. Bitte verwenden Sie dieses, wenn Paketaktualisierungen aufgrund von Bibliotheksinkonsistenzen schwierig werden.  

##### Hinweise.
1. Secure Boot nicht unterstützt  
    Nicht unterstützt, daher bitte Secure Boot in den BIOS-Einstellungen deaktivieren.  
    (Wenn Sie Secure-Boot-Unterstützung wünschen, ist [Ubuntu][Ubuntu] der schnellste Weg. Verschiedene Desktop-Umgebungen sind auch unter [Ubuntu flavours][Ubuntu flavours] verfügbar).

    [Ubuntu]: https://ubuntu.com/download/desktop
    [Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. Wenn der Installer während der manuellen Partitionierung abstürzt.  
    versuchen Sie, zuerst „Koexistenz mit anderen Betriebssystemen“ oder „Partition ersetzen“ auszuwählen, bevor Sie die manuelle Partitionierung wählen. Indem Sie zuerst „Koexistenz mit anderen Betriebssystemen“ oder „Partition ersetzen“ auswählen, können Sie die Sammlung der Partitionierungsinformationen abschließen. Danach wird es einfacher, Abstürze zu vermeiden, wenn Sie die manuelle Partitionierung auswählen.  
    Ich habe einen Merge-Request zur Verbesserung dieses Problems eingereicht, und er wurde in das offizielle Calamares integriert. Er wurde auch im Manjaro Calamares-Repository übernommen, sodass dieses Problem in Zukunft wahrscheinlich auch im offiziellen ISO behoben sein wird.  

3. Wenn die japanische Eingabe in einigen Anwendungen nicht möglich ist  
    Wenn alte Einstellungen beibehalten werden und etwas im `gtk-im-module` eingestellt wurde, kann es vorkommen, dass die japanische Eingabe in einigen Anwendungen nicht möglich ist.
    ```bash
    gsettings get org.gnome.desktop.interface gtk-im-module
    ```
    Wenn dieser Befehl `gtk-im-context-simple` oder ähnliches anzeigt, entfernen Sie die Einstellung mit dem folgenden Befehl.
    ```bash
    gsettings set org.gnome.desktop.interface gtk-im-module ''
    ```

4. Kernel-Unterschiede zum offiziellen Manjaro-Kernel
    Die Kererl-6.6-Serie wurde in der offiziellen Manjaro-ISO verwendet. Das neueste Manjaro scheint auf die Kernel-6.12-Serie umgestiegen zu sein.  
    Die hier verteilte ISO verwendet so weit wie möglich einen neuen Kernel. Derzeit ist es die Kernel-6.12-Serie.  
    Wir verwenden clang anstelle von gcc, um den Kernel und die Kernelmodule zu erstellen.  
    Wir aktivieren auch die Rust-Unterstützung des Kernels.  
    Wenn Sie den offiziellen Manjaro-Kernel verwenden möchten, installieren Sie ihn, indem Sie das Repository 'core' wie in dem folgenden Befehl angeben.
    ```sh
    sudo pacman -S core/linux66 core/linux66-headers
    ```
    ```sh
    sudo pacman -S core/linux612 core/linux612-headers
    ```

5. Japanische Eingabe Bezogen(2024/12/18-)
    - manjaro-asian-input-support-fcitx5  
      Es wurde so modifiziert, dass es sowohl in GNOME- als auch in KDE-Umgebungen unter Wayland oder X11 funktioniert. (Offiziell übernommen.)
    - manjaro-application-utility  
      Jetzt erscheint fcitx5 als Option anstelle von fcitx. (Offiziell übernommen.)
    - fcitx5
      Es wurden Anpassungen vorgenommen, um eine Konfigurationsdatei für KWin zu erstellen, damit fcitx5 aus KWin in der KDE-Umgebung gestartet werden kann.
      (Ich habe ein Paket vorbereitet, das nur das Schreiben der KWin-Konfiguration durchführt. Das AUR-Paket `fcitx5-kde-kwin-settings` gehört dazu.)
    - fcitx5-mozc  
      Wenn die Konfigurationsdatei nicht vorhanden ist, wird sie erstellt und die Standardwerte werden festgelegt.
    - noto-cjk-fontconfig, emoji-fontconfig  
      Ein Paket wurde hinzugefügt, um die Priorität der anzuzeigenden Schriftarten anzupassen.
      ```sh
      paru -S noto-cjk-fontconfig emoji-fontconfig
      ```

##### Hinzugefügt: 2023-02-11  
In der neuesten Version (vom 2023-02-11) von [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/) sind die oben genannten Maßnahmen hinzugefügt worden.  
Außerdem wurde das Installationsprogramm geändert, um einen Prozess zur Aktivierung der Swap-Partition während der Installation hinzuzufügen.
[Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe) hat bereits eine Rückmeldung erhalten.

##### Hinzugefügt: 2023-02-27  
Die obigen Rückmeldungen deuten darauf hin, dass Swap je nach Konfiguration der Partition möglicherweise nicht aktiviert ist.  
Daher wurde als zusätzliche Maßnahme die Verwendung von zram-generator hinzugefügt.

----
### Vertriebsort.
Live-Umgebung & Installations-ISOs sind auf den folgenden Distributionsseiten verfügbar.  
Sie können sie ausprobieren, wenn Sie möchten.

[![SourceForge][SF-ICON-BADGE]][SOURCEFORGE-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-sourceforge.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/sourceforge-icon.svg"/></svg>][SOURCEFORGE-folder]
---|---
[![pCloud][pCloud-ICON]][pCloud-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-pcloud.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/pcloud_icon.svg"/></svg>][pCloud-folder]
[![MEGA][MEGA-ICON]][MEGA-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-mega.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/mega-icon.svg"/></svg>][MEGA-folder]
[![Terabox][TERA-ICON]][TERABOX-folder] | [<svg id = "MANJARO-QR"><image id = "MANJARO-QR" xlink:href = "./img/qr-manjaro-jp-terabox.png"/><image id = "MANJARO-ICON" x="76" y="76" xlink:href = "./img/terabox_logo.svg"/></svg>][TERABOX-folder]

[MEGA-folder]: https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0 "MEGA"
[SOURCEFORGE-folder]: https://sourceforge.net/projects/manjaro-jp/ "SourceForge"
[TERABOX-folder]: https://www.terabox.com/japanese/sharing/link?surl=L_8shPr6AMixSgdsDljFag&path=%2Fmanjaro-jp "TeraBox"
[pCloud-folder]: https://u.pcloud.link/publink/show?code=kZVuHNVZ0ljg4O7Ja2j8YN9KNwFVnfsnoCnX
[MEGA-ICON]: ./img/mega-icon.svg
[SF-ICON]: ./img/sourceforge-icon.svg
[GD-ICON]: ./img/Google_Drive_icon.svg
[TERA-ICON]: ./img/terabox_logo.svg
[pCloud-ICON]: ./img/pcloud_icon.svg
[SF-ICON-BADGE]: https://b.sf-syn.com/badge_img/3508051/oss-sf-favorite-white?achievement=oss-sf-favorite&r=https://manjaro-jp.phoepsilonix.love/index.html

Vielen Dank für die wertvolle Speicherung.  
Er wird an den drei oben genannten Orten verteilt.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), wo Sie Dateien mit einer Größe von 4G oder mehr hochladen können.  
[pCloud](https://partner.pcloud.com/r/119318) unterstützt Größen von 4G und mehr. Es handelt sich um einen Cloud-Speicherdienst mit einem lebenslangen Rückkaufplan.

Wenn Sie von MEGA Storage mit der Befehlszeile herunterladen möchten, ist megatools nützlich.
```bash
sudo pacman -S megatools
```

```bash
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
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
Ich habe ein Paket vorbereitet, um den manjaro-jp Signaturschlüssel zu installieren.  
Wenn ein Fehler aufgrund des manjaro-jp Signaturschlüssels auftritt, versuchen Sie bitte den folgenden Befehl zur Behebung.  
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
Wenn Software hinzugefügt und entfernt wird (pamac update), tritt ein Problem auf, während die Signaturdatei im Repository der signierten Datenbank aktualisiert wird.  
Um dieses Problem zu lösen, habe ich das pacman-Paket fein abgestimmt.  

##### 20230731
* Ich habe es so eingerichtet, dass die Signaturschlüsseldatei von manjaro_jp in der Installationsumgebung geladen wird.(calamares)

Ich glaube, dass durch die Korrektur des pacman-Pakets, die ich zuvor vorgenommen habe, und die Beseitigung der Unstimmigkeiten bei den Signaturschlüsseln, die Fehler vermutlich nicht mehr auftreten werden.  
Sollten dennoch Fehler auftreten, versuchen Sie bitte die folgenden Schritte.  

Initialisieren Sie die Signaturschlüsseldatenbank.
```bash
sudo pacman-key --init
sudo pacman-key --populate
```

Paketinformationen werden neu geladen.
```bash
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* Es wurde ein Problem in [Software hinzufügen/entfernen] behoben, bei dem Paketinformationen beschädigt waren und nach einer Update-Prüfung falsch beendet wurden. (pamac)  
* Bei der Suche nach installierten Paketen in [Software hinzufügen/entfernen] werden nun Flatpak- und Snap-Anwendungen in die Suche einbezogen. (libpamac)  

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

manjaro-jp database signatures have been removed. Only the package will be signed.  
If you get a signature error with pamac, try the following command.
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

##### 20240531
kernel-6.9.3

##### 20240614
kernel-6.9.4

##### 20240617
kernel-6.9.5

##### 20240622
kernel-6.9.6

##### 20240628
kernel-6.9.7

##### 20240706
kernel-6.9.8

##### 20240712
kernel-6.9.9

##### 20240719
kernel-6.9.10

##### 20240725
kernel-6.10.1

##### 20240728
kernel-6.10.2

##### 20240804
kernel-6.10.3

##### 20240815
kernel-6.10.5

##### 20240906
kernel-6.10.8

##### 20240908
kernel-6.10.9

##### 20240912
kernel-6.10.10

##### 20240919
kernel-6.10.11

##### 20241001
kernel-6.10.12

##### 20241007
kernel-6.11.2

##### 20241011
kernel-6.11.3

##### 20241023
kernel-6.11.5

##### 20241101
kernel-6.11.6

##### 20241109
kernel-6.11.7

##### 20241118
kernel-6.12  
Das ZFS-Modul wird nicht unterstützt

##### 20241123
kernel-6.12.1  
Das ZFS-Modul wird nicht unterstützt

##### 20241206
kernel-6.12.3  
Das ZFS-Modul wird nicht unterstützt

##### 20241209
kernel-6.12.4  

##### 20241215
kernel-6.12.5  

##### 20241220
kernel-6.12.6  

##### 20241227
kernel-6.12.7  

##### 20250103
kernel-6.12.8  

##### 20250109
kernel-6.12.9  

##### 20250117
kernel-6.12.10  

##### 20250122
kernel-6.13  
</details>

##### 20250202
kernel-6.13.1  


----
Andere empfohlene Betriebssysteme  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  

[EndeavourOS](https://endeavouros.com/)  

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
[Ihre Unterstützung für diese Aktivität ist sehr willkommen.](./donate.html)  
