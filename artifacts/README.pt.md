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
[![OSDN](https://osdn.net/sflogo.php?group_id=14185&type=1)](https://osdn.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
---|---  
[![SourceForge](https://sourceforge.net/sflogo.php?group_id=66882&type=5)](https://sourceforge.net/projects/manjaro-jp/) | [Manjaro-Linux-jp at SourceForge](https://sourceforge.net/projects/manjaro-jp/)  
[![MEGA](https://mega.nz/favicon.ico)](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A) | [Manjaro-Linux-jp at MEGA](https://mega.nz/folder/YOVmSaxD#JUuILxlHAM9bdyx3DKLD0A)

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
Foi preparado um pacote para instalar a chave para a assinatura manjaro-jp.  
Para além disso, o pacman-init.service inclui agora a assinatura manjaro-jp.  
No pamac (adicionar/remover software), os erros causados pelas assinaturas já não ocorrerão.  

##### 20230724
kernel-6.4.5


---
Informação adicional para referência.  
Se tiver um PC com Linux instalado, pode criar um não-oficial? Se tiver um PC com Linux instalado, pode criar um ambiente de boot duplo com ChromeOS não-oficial (sem suporte oficial). Isto é para pessoas com algum conhecimento.  
Se estiver interessado, por favor consulte [aqui](https://github.com/sebanc/brunch/blob/master/install-with-linux.md). ([Japonês](https://phoepsilonix.love/linux%E3%81%A8chromeos%E3%81%AE%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%97%E3%81%BE%E3%81%97%E3%82%87%E3%81%86%E3%80%82))

---
Outros sistemas operativos recomendados.  
[Fedora Kinoite](https://kinoite.fedoraproject.org/ja/)  

---
```
[manjaro-jp]
SigLevel = Optional TrustAll
Server = https://manjaro-jp.phoepsilonix.love/manjaro-jp/
#Server = https://manjaro-jp.osdn.jp/manjaro-jp/
#Server = https://manjaro-jp.sourceforge.io/manjaro-jp/
```

---
[Manjaro-JP at gitlab](https://gitlab.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at github](https://github.com/phoepsilonix/Manjaro-jp/)  
[Manjaro-JP at sf](https://sourceforge.net/projects/manjaro-jp/)  
[manjaro-jp at OSDN](https://osdn.net/projects/manjaro-jp/)  
(GPG signing public key:57B49CC5AA4F00FC) <phoepsilonix at phoepsilonix dot love>  

---
### O apoio a esta atividade é muito bem-vindo.
[ofuse](https://ofuse.me/phoepsilonix)  
[give me OniGiri](https://www.buymeacoffee.com/phoepsilonix)  

BTC  
```3B6u3pzaeyB2YrDcXWDfGE7pHxx2xuu9KQ```

ETH(main net)  
```0xba50bb991196151b0870e4ea00a518552134c47d```
