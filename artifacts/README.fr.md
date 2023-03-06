# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Prise en charge de la langue japonaise pour [Manjaro Linux](https://manjaro.org/)
　Prise en charge de la saisie et de l'affichage en japonais par défaut, y compris dans les environnements dynamiques.  
[série kernel-6.2(mainline)](https://kernel.org/).

KDE, Xfce et GNOME seront disponibles selon la version officielle.  
Les fichiers de distribution sont des ISO et quelques fichiers de paquets.  
Démarrez à partir d'une clé USB ou similaire.   
Le démarrage à partir d'une clé USB peut être plus facile avec [Ventoy](https://ventoy.net/).  
Il est recommandé de reformater la première partition avec ext4 lors de l'installation de Ventoy.

### Caractéristiques principales.
Le noyau Linux est aussi à jour que possible.  
Le noyau est construit à l'aide de clang.  
L'entrée japonaise (fcitx5-mozc) et les polices japonaises sont installées en standard.  
Les versions Flatpak de [Firefox](https://www.mozilla.org/ja/firefox/browsers/) ou [Floorp](https://floorp.ablaze.one/) seront utilisées comme navigateur standard.  
La version flatpak de [LibreOffice](https://ja.libreoffice.org) sera installée comme logiciel de bureautique standard.

L'environnement réel et les ISO d'installation sont disponibles sur les sites de distribution suivants.  
Vous pouvez l'essayer si vous le souhaitez.

##### Notes.
1. secure boot non pris en charge  
Non pris en charge, veuillez donc désactiver Secure Boot dans les paramètres du BIOS.  
(Si vous souhaitez que le démarrage sécurisé soit pris en charge, Ubuntu est le moyen le plus rapide. Plusieurs environnements de bureau sont également disponibles sur [Ubuntu flavours](https://ubuntu.com/desktop/flavours)).

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

##### Ajouté : 2023-02-11  
Dans la dernière version (du 2023-02-11) de [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), les mesures ci-dessus ont été ajoutées.  
De plus, l'installateur a été modifié pour ajouter un processus permettant d'activer la partition d'échange pendant l'installation.
Le feedback a déjà été fourni à [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Ajouté : 2023-02-17  
Les commentaires ci-dessus indiquent que le swap peut ne pas être activé selon la façon dont la partition est configurée.  
Par conséquent, comme mesure supplémentaire, l'utilisation de zram-generator a été ajoutée.

### Lieu de distribution.
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A)

Merci pour ce précieux stockage.  
Il est distribué dans les trois emplacements ci-dessus.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), où vous pouvez télécharger des fichiers d'une taille de 4G ou plus.

---
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
</details>

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


---
Informations supplémentaires pour référence.  
Si vous disposez d'un PC avec Linux installé, vous pouvez créer un environnement non officiel ? Si vous avez un PC avec Linux installé, vous pouvez créer un environnement dual-boot avec ChromeOS non officiel (pas de support officiel). Ceci s'adresse aux personnes ayant quelques connaissances.  
Si vous êtes intéressé, veuillez vous reporter à [ici](https://github.com/sebanc/brunch/blob/master/install-with-linux.md). ([Japonais](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82))

---
Dans la famille ArchLinux, qui se caractérise par des mises à jour régulières, [Garuda Linux](https://garudalinux.org) a également bonne mine.

---
Autres systèmes d'exploitation recommandés  
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
```15wwyVLTCtd1i4tuArwAcsCYPb2YBFH1CB```

ETH(main net)  
```0x6d814317881ee2ea617fa6989f255f19b949eb60```

USDT(ERC20)  
```0x7e92844d51094eb164a7f4444524b55c31748546```
