## [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Suporte em língua japonesa para [Manjaro Linux](https://manjaro.org/)
　Suporta a entrada e exibição japonesa por defeito, incluindo ambientes ao vivo.  
[kernel-6.4 series](https://kernel.org/).

KDE, Xfce e GNOME estarão disponíveis de acordo com a versão oficial.  
Os ficheiros de distribuição são ISO e alguns ficheiros de pacotes.  
Arranque a partir de uma memória USB ou similar.   
Arrancar a partir de um cartão de memória USB pode ser mais fácil com [Ventoy](https://ventoy.net/).  
Recomenda-se reformatar a primeira partição com ext4 ao instalar Ventoy.

### Características principais.
O kernel Linux está tão actualizado quanto possível.  
Além disso, o clang é utilizado para construir o kernel.  
A entrada japonesa (fcitx5-mozc) e as fontes japonesas são instaladas como padrão.  
As versões Flatpak de [Firefox](https://www.mozilla.org/ja/firefox/browsers/) ou [Floorp](https://floorp.ablaze.one/) serão utilizadas como o navegador padrão.  
A versão flatpak [LibreOffice](https://ja.libreoffice.org) será instalada como software de escritório standard.  
Instalamos o pacote pacman-static por padrão. Por favor, use-o se as atualizações de pacotes se tornarem difíceis devido a inconsistências da biblioteca.  

Os ISOs para ambiente vivo e instalação estão disponíveis nos seguintes locais de distribuição.  
Se desejar, pode experimentá-lo.

##### Notas.
1. bota segura não suportada  
Não suportado, por isso, por favor, desactivar o Secure Boot nas definições da BIOS.  
(Se quiser suporte de arranque seguro, o Ubuntu é a forma mais rápida. Vários ambientes de trabalho estão também disponíveis em [Ubuntu flavours](https://ubuntu.com/desktop/flavours)).

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

##### Adicionado: 2023-02-11  
Na última versão (de 2023-02-11) de [Manjaro-JP](https://sourceforge.net/projects/manjaro-jp/), as medidas acima foram acrescentadas.  
O instalador também foi modificado para adicionar um processo para permitir a partição swap durante a instalação.
O feedback já foi fornecido a [Calamares](https://github.com/calamares/calamares/pull/2102/commits/79d796a437ad039745147c62a652035d4cd882fe).

##### Adicionado: 2023-02-27  
O feedback acima indicado indica que a troca pode não ser activada dependendo de como a partição está configurada.  
Portanto, como medida adicional, foi adicionado o uso de zram-generador.

---
### Localização de distribuição.
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A/aff=gVLIePn4Hy0)
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![Google Drive](./Google_Drive_icon.svg)](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing) | [Manjaro-Linux-jp at Google Drive](https://drive.google.com/drive/folders/1sEACfS24Mci6FnC5jyca9muoiVABCBlv?usp=sharing)
[!<img src="data:image/png;base64,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" width="180">](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg) | [Manjaro-Linux-jp at Terabox](https://teraboxapp.com/s/1FdwBohvbmNkXNSEK6eBSAg)  

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
</details>

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


---
Outros sistemas operativos recomendados.  
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
### O apoio a esta atividade é muito bem-vindo.
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
