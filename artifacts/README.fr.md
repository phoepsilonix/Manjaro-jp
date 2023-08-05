# [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Prise en charge de la langue japonaise pour [Manjaro Linux](https://manjaro.org/)
　Prise en charge de la saisie et de l'affichage en japonais par défaut, y compris dans les environnements dynamiques.  
[série kernel-6.4](https://kernel.org/).

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
Nous avons installé le paquet pacman-static par défaut. Veuillez l'utiliser si les mises à jour des paquets deviennent difficiles en raison d'incohérences de bibliothèque.  

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
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[!<img src="data:image/png;base64,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" width="180">](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg) | [Manjaro-Linux-jp at Terabox](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg)  

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


---
Autres systèmes d'exploitation recommandés  
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
### Votre soutien pour cette activité est très bienvenu.  
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
