# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Prise en charge de la langue japonaise pour [Manjaro Linux](https://manjaro.org/)
　Prise en charge de la saisie et de l'affichage en japonais par défaut, y compris dans les environnements dynamiques.  
[série kernel-6.7](https://kernel.org/).

KDE, Xfce et GNOME seront disponibles selon la version officielle.  
Les fichiers de distribution sont des ISO et quelques fichiers de paquets.  
Démarrez à partir d'une clé USB ou similaire.   
Le démarrage à partir d'une clé USB peut être plus facile avec [Ventoy](https://ventoy.net/).  
Il est recommandé de reformater la première partition avec ext4 lors de l'installation de Ventoy.

----
### À propos de l’installation de Ventoy
Étapes pour installer ventoy sur une clé USB en utilisant Manjaro Linux
```
sudo pacman -S ventoy
ventoygui
```
Linux général  
Exemple de commande de téléchargement en utilisant aria2  
```
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-linux.tar.gz
tar xf ventoy-1.0.97-linux.tar.gz
cd ventoy-1.0.97
./VentoyGUI.x86_64 
```

Windows  
Téléchargez [Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.0.97/ventoy-1.0.97-windows.zip) à l’aide d’un navigateur ou autre chose.  
Ouvrez le fichier zip téléchargé et exécutez ventoy2disk.exe.

----
### Caractéristiques principales.
Le noyau Linux est aussi à jour que possible.  
Le noyau est construit à l'aide de clang.  
L'entrée japonaise (fcitx5-mozc) et les polices japonaises sont installées en standard.  
[Floorp](https://floorp.ablaze.one/) seront utilisées comme navigateur standard.  
[LibreOffice](https://ja.libreoffice.org) sera installée comme logiciel de bureautique standard.  
Nous avons installé le paquet pacman-static par défaut. Veuillez l'utiliser si les mises à jour des paquets deviennent difficiles en raison d'incohérences de bibliothèque.  

##### Notes.
1. secure boot non pris en charge  
Non pris en charge, veuillez donc désactiver Secure Boot dans les paramètres du BIOS.  
(Si vous souhaitez que le démarrage sécurisé soit pris en charge, [Ubuntu][Ubuntu] est le moyen le plus rapide. Plusieurs environnements de bureau sont également disponibles sur [Ubuntu flavours][Ubuntu flavours]).

[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. si l'écran d'installation disparaît pendant l'installation  
Ce problème peut souvent être évité en activant manuellement la partition swap.  
Si la partition swap est /dev/sdX, essayez d'activer le swap manuellement avec la commande suivante.

```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# Si le swap n'est pas activé, utilisez lsblk pour examiner le périphérique et activer la partition swap.
[[ $(swapon --show) == "" ]] &&  SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```
La commande suivante doit également être utilisée pour spécifier que le tueur OOM (terminaison forcée) n'est pas applicable.
```
pidof -xw Xwayland calamares_polkit | xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

3. Lorsque la saisie du japonais n'est pas possible dans certaines applications  
Si d'anciens réglages subsistent et que quelque chose a été défini dans gtk-im-module, il peut y avoir des cas où vous ne pouvez pas saisir le japonais dans certaines applications.
```
gsettings get org.gnome.desktop.interface gtk-im-module
```
Si cette commande affiche 'gtk-im-context-simple' ou similaire, supprimez le paramètre avec la commande suivante.
```
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

##### Ajouté : 2023-02-11  
Dans la dernière version (du 2023-02-11) de [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), les mesures ci-dessus ont été ajoutées.  
De plus, l'installateur a été modifié pour ajouter un processus permettant d'activer la partition d'échange pendant l'installation.
Le feedback a déjà été fourni à [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Ajouté : 2023-02-17  
Les commentaires ci-dessus indiquent que le swap peut ne pas être activé selon la façon dont la partition est configurée.  
Par conséquent, comme mesure supplémentaire, l'utilisation de zram-generator a été ajoutée.

### Lieu de distribution.
L'environnement réel et les ISO d'installation sont disponibles sur les sites de distribution suivants.  
Vous pouvez l'essayer si vous le souhaitez.

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

Merci pour ce précieux stockage.  
Il est distribué dans les trois emplacements ci-dessus.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), où vous pouvez télécharger des fichiers d'une taille de 4G ou plus.

Si vous voulez télécharger depuis MEGA Storage en utilisant la ligne de commande, megatools est utile.
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

----
### Memorandum
##### modifications de manjaro-tools-iso
1. la première ligne de la liste des miroirs est utilisée comme standard pour savoir où obtenir les paquets utilisés pour buildiso.  
Par défaut, la mirrorlist n'est pas chargée et le serveur EU est utilisé.
2. la priorisation de l'ordre des dépôts spécifiés dans user-repos.conf afin d'inclure les paquets que vous avez préparés dans l'ISO.  
Ceci est principalement pour inclure les dernières versions du noyau.

### Historique des mises à jour
<details><summary>Historique à ce jour</summary>.

##### 20220401
kernel-5.17.1 (construction clang).  
Le paquet linux517-broadcom-wl,linux517-zfs a également été construit et ajouté.  
Voir [gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp) et [Packages folder](https://gitlab.com/phoepsilonix/) pour les détails des modifications apportées au paquet broadcom-wl-dkms et d'autres informations. Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms).

##### 20220408
Le seul navigateur standard est [Vivaldi](https://vivaldi.com/).  
Vous êtes bien sûr libre de passer à tout autre navigateur.  
Les valeurs par défaut de GRUB au démarrage pour les environnements vivants ont été modifiées pour le Japon.

##### 20220411
Correction de bogues dans la mise à jour du paquet.  
Ajout de polices japonaises.  
Polices Morisawa BIZ UD [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706), [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706) et [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706), qui ont été [publiées sous la licence SIL OFL](https://www.morisawa.co.jp/) par [Morisawa Inc. Morisawa BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho) et [Morisawa BIZ UD Gothic](https://github.com/googlefonts/). morisawa-biz-ud-gothic) sont préinstallées.  
Les polices sont incluses telles qu'elles sont publiées sur Github. Il inclut également le fichier de licence, etc. (Je l'ai également construit moi-même et n'ai trouvé aucune différence dans les binaires).
Pour plus d'informations, voir le site original ci-dessus ou la documentation Github.  
Support [Morisawa BIZ+ font](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/).

##### 20220413
Enregistrer le paquet de polices Morisawa BIZ UD auprès de l'AUR.

##### 20220414
Mise à jour vers kernel-5.17.3.

##### 20220421
Mise à jour vers kernel-5.17.4.

##### 20220422
Entrée japonaise changée en fcitx5-mozc.

##### 20220424
Clavier japonais et Mozc activés en standard.

##### 20220428
Noyau-5.17.5

##### 20220510
Noyau-5.17.6

##### 20220513
Environnement de bureau GNOME mis à jour vers GNOME42.

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
Noyau-5.17.11

##### 20220527
Mise à jour de la version du pilote nvidia à 515.43.04.
Ajout de la série kernel-5.18.

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
Noyau-5.17.13
kernel-5.18.2

##### 20220608
Changements relatifs aux logiciels de bureautique  
La sélection des logiciels de bureautique dans l'installateur a été supprimée.  
Principalement pour réduire l'encombrement, la sélection des logiciels de bureautique dans le programme d'installation a été supprimée et le logiciel de bureautique standard installé est passé de onlyoffice-desktopeditor à libreoffice-fresh.

##### 20220611
kernel-5.17.14  
kernel-5.18.3  
Mise à jour de la version du pilote nvidia à 515.48.07.  
Correction de virtualbox-host-dkms pour construire sur linux518.  
Ajout du paquet nginx-quic et d'autres paquets au dépôt manjaro-jp, bien que non inclus dans l'ISO.  
Inclusion du dépôt manjaro-jp dans pacman.conf.

##### 20220614
Correction de bogues dans l'installateur.  
Changement d'éditeur de gedit à gnome-text-editor dans la version GNOME.

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6  
Passage de manjaro-pulse, lié à l'audio, à manjaro-pipewire.

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8  
nvidia-utils 515.57

##### 20220703
noyau-5.18.9

##### 20220706
Activation de cups-browsed.  
Ajout du paquet ipp-usb.

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
Le navigateur standard a été modifié en [Floorp](https://floorp.ablaze.one/).

##### 20221105
kernel-6.0.7  
mkinitcpio-32-2

##### 20221112
Version Flatpak de [Firefox](https://www.mozilla.org/ja/firefox/browsers/) ou [Floorp](https://floorp.ablaze.one/) comme navigateur standard.  
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10  
LibreOffice a été changé pour la version flatpak.  
Le clavier par défaut de fcitx5 a été modifié en japonais (Kana 86).  
Changement de la police par défaut de gnome-terminal en FirgeNerd Console.  
Les polices suivantes ont été préinstallées.  
[Firge : police de programmation Firge (Firge), un composite de Fira Mono et Gen Shin Gothic](https://github.com/yuru7/Firge)  
[HackGen : police de programmation combinant Hack et Genju Gothic Hakugen (HackGen)](https://github.com/yuru7/HackGen)

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
L'URL du dépôt pour Manjaro-jp a changé.  
(De OSDN à OSDN Web. Peut être temporaire).  
Les fichiers ISO sont distribués sur [SourceForge](https://sourceforge.net/projects/manjaro-jp/).  
Quelques modifications à l'installateur de Calamares.  
(Réduit le nombre de cas où l'installateur est obligé de se terminer sous une charge élevée).   

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

* Nous avons temporairement publié un paquetage dont le fonctionnement n'a pas été entièrement testé.  
Veuillez essayer de réinstaller le paquet distribué par la distribution officielle de Manjaro avec la commande suivante.
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
J'ai préparé un paquet pour installer la clé de signature manjaro-jp.  
Si une erreur se produit en raison de la clé de signature manjaro-jp, veuillez essayer la commande suivante pour la corriger.
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
Lors de l'ajout et de la suppression de logiciels (pamac update), un problème se produit lors de la mise à jour du fichier de signature dans le référentiel de la base de données signée.  
Pour résoudre ce problème, j'ai affiné le paquet pacman.  

##### 20230731
* J'ai configuré pour charger le fichier de clé de signature manjaro_jp dans l'environnement d'installation.(calamares)

Je pense qu'avec la correction du paquet pacman que j'ai effectuée précédemment et l'élimination des incohérences dans les clés de signature, les cas d'erreurs devraient avoir été éliminés.  
Cependant, si une erreur se produit, veuillez essayer les étapes suivantes.  

Initialisez la base de données de clés de signature.
```
sudo pacman-key --init
sudo pacman-key --populate
```

Recharger les informations sur le paquet.
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* Correction d’un problème dans [Ajout/Suppression de logiciel] où les informations du package sont corrompues et se terminent de manière incorrecte après une vérification de mise à jour. (pamac)  
* Lors de la recherche de paquets installés dans [Ajout/Suppression de logiciels], les applications flatpak et snap sont maintenant incluses dans la recherche. (libpamac)  

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

##### 20240127
kernel-6.7.2

##### 20240206
kernel-6.7.4

##### 20240218
kernel-6.7.5


----
Autres systèmes d'exploitation recommandés  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE MicroOS](https://get.opensuse.org/fr/microos/)  

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
### Votre soutien pour cette activité est très bienvenu.  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
