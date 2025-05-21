## [Manjaro Linux JP](https://sourceforge.net/projects/manjaro-jp/)

## Suporte em língua japonesa para [Manjaro Linux](https://manjaro.org/)
　Suporta a entrada e exibição japonesa por defeito, incluindo ambientes ao vivo.  
[kernel-6.14 series](https://kernel.org/).

KDE, Xfce e GNOME estarão disponíveis de acordo com a versão oficial.  
Os ficheiros de distribuição são ISO e alguns ficheiros de pacotes.  
Arranque a partir de uma memória USB ou similar.   
Arrancar a partir de um cartão de memória USB pode ser mais fácil com [Ventoy](https://ventoy.net/).  
Recomenda-se reformatar a primeira partição com ext4 ao instalar Ventoy.

### Sobre a instalação do Ventoy
Passos para instalar o ventoy em um pen drive usando o Manjaro Linux
```bash
sudo pacman -S ventoy
ventoygui
```
Linux geral  
Exemplo de comando de download usando aria2
```bash
aria2c -c https://github.com/ventoy/Ventoy/releases/download/v1.1.05/ventoy-1.1.05-linux.tar.gz
tar xf ventoy-1.1.05-linux.tar.gz
cd ventoy-1.1.05
./VentoyGUI.$(uname -m)
```

Windows
Baixe o [Ventoy](https://github.com/ventoy/Ventoy/releases/download/v1.1.05/ventoy-1.1.05-windows.zip) usando um navegador ou algo assim.  
Abra o arquivo zip baixado e execute o ventoy2disk.exe.

----
### Características principais.
O kernel Linux está tão actualizado quanto possível.  
Além disso, o clang é utilizado para construir o kernel.  
A entrada japonesa (fcitx5-mozc) e as fontes japonesas são instaladas como padrão.  
As versões [Floorp](https://floorp.ablaze.one/) serão utilizadas como o navegador padrão.  
Instalamos o pacote pacman-static por padrão. Por favor, use-o se as atualizações de pacotes se tornarem difíceis devido a inconsistências da biblioteca.  

##### Notas.
1. bota segura não suportada  
    Não suportado, por isso, por favor, desactivar o Secure Boot nas definições da BIOS.  
    (Se quiser suporte de arranque seguro, o [Ubuntu][Ubuntu] é a forma mais rápida. Vários ambientes de trabalho estão também disponíveis em [Ubuntu flavours][Ubuntu flavours]).

    [Ubuntu]: https://ubuntu.com/download/desktop
    [Ubuntu flavours]: https://ubuntu.com/desktop/flavours

2. Se o instalador travar durante a partição manual.  
    tente selecionar "Coexistência com outros sistemas operacionais" ou "Substituir partição" antes de escolher a partição manual. Ao selecionar "Coexistência com outros sistemas operacionais" ou "Substituir partição" primeiro, você pode completar a coleta das informações da partição. Depois disso, selecionar a partição manual facilitará a evitação de travamentos.  
    Eu enviei um pedido de mesclagem para melhorar este problema, e ele foi incorporado ao Calamares oficial. Também foi refletido no repositório Calamares do Manjaro, então, no futuro, esse problema provavelmente será resolvido na ISO oficial.  

3. Quando não é possível introduzir a língua japonesa em algumas aplicações  
    Algumas aplicações podem não ser capazes de introduzir o japonês se a configuração antiga ainda estiver em vigor e algo tiver sido definido no `gtk-im-module`.
    ```bash
    gsettings get org.gnome.desktop.interface gtk-im-module
    ```
    Se este comando mostrar `gtk-im-context-simple` ou similar, remova a configuração com o seguinte comando.
    ```bash
    gsettings set org.gnome.desktop.interface gtk-im-module ''
    ```

4. diferenças em relação ao kernel oficial do Manjaro
    A série kererl-6.6 foi usada no iso oficial Manjaro. O último Manjaro parece ter mudado para a série kernel-6.12.  
    O ISO distribuído aqui usa um novo kernel tanto quanto possível. Atualmente, é a série kernel-6.14.  
    O kernel e os módulos do kernel são construídos usando clang em vez de gcc.  
    Nós também habilitamos o suporte a Rust no kernel.  
Se você quiser usar o kernel oficial do Manjaro, instale-o especificando o repositório 'core', como no seguinte comando.
    ```sh
    sudo pacman -S core/linux66 core/linux66-headers
    ```
    ```sh
    sudo pacman -S core/linux612 core/linux612-headers
    ```

5. limitações relativas ao VirtualBox  
    O kernel fornecido pelo Manjaro-JP como padrão é um kernel com CONFIG_CFI_CLANG ativado, por isso o virtualbox pode não funcionar.  
    Se isto não funcionar, por favor use o kernel fornecido pelo Manjaro-JP ou outros kernels oficiais do Manjaro.

6. Relacionado à entrada em japonês  
    - manjaro-asian-input-support-fcitx5  
      Foi modificado para funcionar tanto em ambientes GNOME quanto KDE no Wayland ou X11. (Adotado oficialmente.)
    - manjaro-application-utility  
      Agora, fcitx5 aparece como uma opção em vez de fcitx. (Adotado oficialmente.)
    - fcitx5  
      Ajustes foram feitos para criar um arquivo de configuração para KWin, de modo que o fcitx5 possa ser iniciado a partir do KWin no ambiente KDE.
      (Preparei um pacote que apenas escreve a configuração do KWin. O pacote AUR `fcitx5-kde-kwin-settings` corresponde a isso.)
    - fcitx5-mozc  
      Se o arquivo de configuração não existir, ele será criado com valores padrão definidos.
    - noto-cjk-fontconfig, emoji-fontconfig  
      Um pacote foi adicionado para ajustar a prioridade das fontes a serem exibidas.
      ```sh
      paru -S noto-cjk-fontconfig emoji-fontconfig
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

Obrigado pelo valioso armazenamento.  
É distribuído nos três locais acima referidos.

[MEGA Storage](https://mega.nz/storage/aff=gVLIePn4Hy0), onde pode carregar ficheiros de 4G ou mais em tamanho.  
[pCloud] (https://partner.pcloud.com/r/119318), tamanhos maiores que 4G não são problema. Este sistema de armazenamento na nuvem também tem um plano de compra vitalício.

Se você quiser baixar do MEGA Storage usando a linha de comando, o megatools é útil.
```bash
sudo pacman -S megatools
```

```bash
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
Preparei um pacote para instalar a chave de assinatura manjaro-jp.  
Se ocorrer um erro devido à chave de assinatura manjaro-jp, tente o seguinte comando para corrigi-lo.  
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
Ao adicionar e remover software (pamac update), ocorre um problema ao atualizar o arquivo de assinatura no repositório do banco de dados assinado.  
Para resolver este problema, eu ajustei o pacote pacman.  

##### 20230731
* Configurei para carregar o arquivo de chave de assinatura do manjaro_jp no ambiente de instalação.(calamares)

Acredito que, com a correção do pacote pacman que fiz anteriormente e a eliminação de inconsistências nas chaves de assinatura, os casos de ocorrência de erros devem ter sido eliminados.  
No entanto, se ocorrer um erro, por favor, tente os seguintes passos.  

Inicialize o banco de dados de chave de assinatura.
```bash
sudo pacman-key --init
sudo pacman-key --populate
```

Recarregar as informações do pacote.
```bash
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
O módulo zfs não é compatível

##### 20241123
kernel-6.12.1  
O módulo zfs não é compatível

##### 20241206
kernel-6.12.3  
O módulo zfs não é compatível

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

##### 20250202
kernel-6.13.1  

##### 20250208
kernel-6.13.2  

##### 20250218
kernel-6.13.3  

##### 20250228
kernel-6.13.5  

##### 20250325
kernel-6.13.8  

##### 20250414
kernel-6.14.2  

##### 20250426
kernel-6.14.4  

##### 20250503
kernel-6.14.5  
</details>

##### 20250510
kernel-6.14.6  

----
Outros sistemas operativos recomendados.  
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
[O apoio a esta atividade é muito bem-vindo.](./donate.html)  
