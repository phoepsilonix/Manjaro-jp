## [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Suporte em língua japonesa para [Manjaro Linux](https://manjaro.org/)
　Suporta a entrada e exibição japonesa por defeito, incluindo ambientes ao vivo.  
[kernel-6.6 series](https://kernel.org/).

KDE, Xfce e GNOME estarão disponíveis de acordo com a versão oficial.  
Os ficheiros de distribuição são ISO e alguns ficheiros de pacotes.  
Arranque a partir de uma memória USB ou similar.   
Arrancar a partir de um cartão de memória USB pode ser mais fácil com [Ventoy](https://ventoy.net/).  
Recomenda-se reformatar a primeira partição com ext4 ao instalar Ventoy.

### Sobre a instalação do Ventoy
Passos para instalar o ventoy em um pen drive usando o Manjaro Linux
```
sudo pacman -S ventoy
ventoygui
```
Linux geral  
Exemplo de comando de download usando aria2
```
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.0.96/ventoy-1.0.96-linux.tar.gz
tar xf ventoy-1.0.96-linux.tar.gz
cd ventoy-1.0.96
./VentoyGUI.x86_64 
```

Windows
Baixe o [Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.0.96/ventoy-1.0.96-windows.zip) usando um navegador ou algo assim.  
Abra o arquivo zip baixado e execute o ventoy2disk.exe.

----
### Características principais.
O kernel Linux está tão actualizado quanto possível.  
Além disso, o clang é utilizado para construir o kernel.  
A entrada japonesa (fcitx5-mozc) e as fontes japonesas são instaladas como padrão.  
As versões [Floorp](https://floorp.ablaze.one/) serão utilizadas como o navegador padrão.  
A versão [LibreOffice](https://ja.libreoffice.org) será instalada como software de escritório standard.  
Instalamos o pacote pacman-static por padrão. Por favor, use-o se as atualizações de pacotes se tornarem difíceis devido a inconsistências da biblioteca.  

##### Notas.
1. bota segura não suportada  
Não suportado, por isso, por favor, desactivar o Secure Boot nas definições da BIOS.  
(Se quiser suporte de arranque seguro, o [Ubuntu][Ubuntu] é a forma mais rápida. Vários ambientes de trabalho estão também disponíveis em [Ubuntu flavours][Ubuntu flavours]).

[Ubuntu]: https://ubuntu.com/download/desktop
[Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. Se o ecrã do instalador desaparecer durante a instalação  
É muitas vezes possível evitar isto, definindo manualmente a partição swap.  
Se a partição swap for /dev/sdX, tente activar a partição swap manualmente com o seguinte comando.
```
sudo mkswap /dev/sdX
sudo swapon /dev/sdX
```
```
# Se a swap não estiver activada, utilizar lsblk para examinar o dispositivo e activar a partição swap.
[[ $(swapon --show) == "" ]] &&  SWAP=$(lsblk -l -f -n -p | awk '{if ($2=="swap") print $1}') && ( sudo swapon $SWAP || (sudo mkswap $SWAP && sudo swapon $SWAP) )
```

O seguinte comando deve também ser utilizado para especificar que o assassino OOM (terminação forçada) não é aplicável.
```
pidof -xw Xwayland calamares_polkit | xargs -n1 sudo choom -n -1000 -p
pidof -xw gnome-shell gnome-session-binary xdg-desktop-portal-gnome gdm gjs gvfsd-fuse udisksd | xargs -n1 sudo choom -n -1000 -p
```

3. Quando não é possível introduzir a língua japonesa em algumas aplicações  
Se as definições antigas se mantiverem e algo tiver sido definido no módulo gtk-im, pode haver casos em que não seja possível introduzir japonês em algumas aplicações.
```
gsettings get org.gnome.desktop.interface gtk-im-module
```
Se este comando mostrar 'gtk-im-context-simple' ou similar, remova a configuração com o seguinte comando.
```
gsettings set org.gnome.desktop.interface gtk-im-module ''
```

##### Adicionado: 2023-02-11  
Na última versão (de 2023-02-11) de [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), as medidas acima foram acrescentadas.  
O instalador também foi modificado para adicionar um processo para permitir a partição swap durante a instalação.
O feedback já foi fornecido a [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Adicionado: 2023-02-27  
O feedback acima indicado indica que a troca pode não ser activada dependendo de como a partição está configurada.  
Portanto, como medida adicional, foi adicionado o uso de zram-generador.

---
### Localização de distribuição.
Os ISOs para ambiente vivo e instalação estão disponíveis nos seguintes locais de distribuição.  
Se desejar, pode experimentá-lo.

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

Obrigado pelo valioso armazenamento.  
É distribuído nos três locais acima referidos.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), onde pode carregar ficheiros de 4G ou mais em tamanho.

Se você quiser baixar do MEGA Storage usando a linha de comando, o megatools é útil.
```
sudo pacman -S megatools
```

```
megatools dl --choose-files https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A
```

### Memorando
##### manjaro-tools-iso mudanças
1. A primeira linha da lista de espelhos é utilizada como padrão para onde obter os pacotes utilizados para o buildiso.  
Por defeito, a lista de espelhos não é carregada e o servidor da UE é utilizado.
2. a prioridade da ordem dos repositórios especificados no user-repos.conf de modo a incluir os pacotes que preparou na ISO.  
Isto é principalmente para incluir as versões mais recentes do kernel.

### Histórico de actualizações
<details><summary>Past</summary>.

##### 20220401
kernel-5.17.1 (construção clang)  
linux517-broadcom-wl,linux517-zfs pacotes também construídos e adicionados.  
Consulte a [pasta Packages](https://gitlab.com/phoepsilonix/Manjaro-jp/-/tree/main/Packages/broadcom-wl-dkms) no gitlab para informações sobre modificações ao pacote broadcom-wl-dkms.

##### 20220408
O único navegador padrão é [Vivaldi](https://vivaldi.com/).  
Evidentemente, pode mudar livremente para outros navegadores.  
Os valores padrão do GRUB no arranque para ambientes ao vivo foram alterados para o Japão.

##### 20220411
Correcções de bugs de actualização de pacotes.  
Adição de fontes japonesas.  
Tipos de letra Morisawa BIZ UD [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706), [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706) e [Morisawa BIZ UD Mincho](https://www.morisawa.co.jp/about/news/6706), que foram [lançados sob a licença SIL OFL](https://www.morisawa.co.jp/) pela [Morisawa Inc.]. Morisawa BIZ UD Mincho](https://github.com/googlefonts/morisawa-biz-ud-mincho) e fontes [Morisawa BIZ UD Gothic](https://github.com/googlefonts/). morisawa-biz-ud-gothic) são pré-instaladas.  
As fontes são incluídas à medida que são publicadas no Github. Também inclui o ficheiro da licença, etc. (Eu próprio também o construí e não encontrei diferenças nos binários).
Para mais informações, ver o sítio original acima ou a documentação do Github.  
Apoio [fonte Morisawa BIZ+](https://www.morisawa.co.jp/products/fonts/bizplus/lineup/).

##### 20220413
Pacote de fontes de Morisawa BIZ UD registadas na AUR.

##### 20220414
Actualizado para kernel-5.17.3.

##### 20220421
Actualizado para kernel-5.17.4.

##### 20220422
Entrada japonesa alterada para fcitx5-mozc.

##### 20220424
Teclado japonês e Mozc activados como padrão.

##### 20220428
kernel-5.17.5

##### 20220510
kernel-5.17.6

##### 20220513
Ambiente de trabalho GNOME actualizado para GNOME42.

##### 20220517
kernel-5.17.8

##### 20220519
kernel-5.17.9

##### 20220526
kernel-5.17.11

##### 20220527
Versão actualizada do condutor da nvidia para 515.43.04.
Adicionada a série kernel-5.18.

##### 20220531
kernel-5.17.12
kernel-5.18.1

##### 20220607
kernel-5.17.13
kernel-5.18.2

##### 20220608
Mudanças no software de escritório  
A selecção de software de escritório no instalador foi eliminada.  
Principalmente para reduzir os requisitos de espaço, a selecção de software de escritório no instalador foi removida e o software de escritório padrão instalado foi alterado de onlyoffice-desktopeditor para libreoffice-fresh.

##### 20220611
kernel-5.17.14  
kernel-5.18.3  
Versão actualizada do driver nvidia para 515.48.07.  
Virtualbox-host-dkms fixo para construir sobre linux518.  
Adicionado o pacote nginx-quic e outros pacotes ao repositório manjaro-jp, embora não incluído na ISO.  
Incluído o repositório manjaro-jp em pacman.conf.

##### 20220614
Correcções de bugs do instalador.  
Mudou o editor de gedit para gnome-text-editor na versão GNOME.

##### 20220619
kernel-5.18.5

##### 20220624
kernel-5.18.6  
Mudança de manjaro-pulso relacionado com o áudio para manjaro-pipewire.

##### 20220627
kernel-5.18.7

##### 20220630
kernel-5.18.8  
nvidia-utils 515.57

##### 20220703
kernel-5.18.9

##### 20220706
Taças de copos habilitados.  
Adicionado o pacote ipp-usb.

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
O navegador padrão mudou para [Floorp](https://floorp.ablaze.one/).

##### 20221105
kernel-6.0.7  
mkinitcpio-32-2

##### 20221112
A versão flatpak [Firefox](https://www.mozilla.org/ja/firefox/browsers/) ou [Floorp](https://floorp.ablaze.one/) é utilizada como o navegador padrão.  
kernel-6.0.8

##### 20221118
kernel-6.0.9

##### 20221128
kernel-6.0.10  
Mudou o LibreOffice para a versão flatpak.  
Alterado o teclado padrão do fcitx5 para japonês (Kana 86).  
Alterada a fonte padrão do gnome-terminal para FirgeNerd Console.  
As seguintes fontes foram pré-instaladas.  
[Firge: fonte de programação Firge (Firge), um composto de Fira Mono e Gen Shin Gothic](https://github.com/yuru7/Firge)  
[HackGen: fonte de programação combinando Hack e Genju Gothic Hakugen (HackGen)](https://github.com/yuru7/HackGen)

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
URL do repositório Manjaro-jp alterada.  
(De OSDN para OSDN Web. Pode ser temporário).  
Os ficheiros ISO são distribuídos em [SourceForge](https://sourceforge.net/projects/manjaro-jp/).  
Algumas modificações no instalador de Calamares.  
(Reduz o número de casos em que o instalador é forçado a fechar sob carga elevada).   

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

* Lançámos temporariamente um pacote que não foi totalmente testado para funcionar.  
Por favor, tente reinstalar o pacote distribuído pela distribuição oficial Manjaro com o seguinte comando.
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
Preparei um pacote para instalar a chave de assinatura manjaro-jp.  
Se ocorrer um erro devido à chave de assinatura manjaro-jp, tente o seguinte comando para corrigi-lo.  
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
Ao adicionar e remover software (pamac update), ocorre um problema ao atualizar o arquivo de assinatura no repositório do banco de dados assinado.  
Para resolver este problema, eu ajustei o pacote pacman.  

##### 20230731
* Configurei para carregar o arquivo de chave de assinatura do manjaro_jp no ambiente de instalação.(calamares)

Acredito que, com a correção do pacote pacman que fiz anteriormente e a eliminação de inconsistências nas chaves de assinatura, os casos de ocorrência de erros devem ter sido eliminados.  
No entanto, se ocorrer um erro, por favor, tente os seguintes passos.  

Inicialize o banco de dados de chave de assinatura.
```
sudo pacman-key --init
sudo pacman-key --populate
```

Recarregar as informações do pacote.
```
sudo pacman -Syy
sudo pacman -Fyy
```

##### 20230805
* Corrigido um problema em [Adicionar/Remover Software] em que as informações do pacote estavam corrompidas e terminavam incorretamente após uma verificação de atualização. (pamac)   
* Ao procurar pacotes instalados em [Adicionar/Remover Software], as aplicações flatpak e snap estão agora incluídas na pesquisa. (libpamac)   

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


----
Outros sistemas operativos recomendados.  
[Ubuntu][Ubuntu]  
[Ubuntu flavours][Ubuntu flavours]  

[Linux Mint](https://linuxmint.com/)  
[MX Linux](https://mxlinux.org/)  

[EndeavourOS](https://endeavouros.com/)  

[openSUSE MicroOS](https://get.opensuse.org/pt/microos/)  

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
### O apoio a esta atividade é muito bem-vindo.
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
