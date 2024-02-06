## 📚 Documentação

[Objetivo](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/PBD-Atividade%20de%20Linux%20-%20AWS%20-%20UNICESUMAR-290124-210439.pdf)

A tarefa envolve criar uma chave pública para acesso, o provisionamento de uma instância EC2 utilizando o sistema operacional Amazon Linux 2, a alocação de um endereço IP elástico que será associado à instância EC2, a abertura de portas de comunicação para permitir acesso público, a configuração do sistema de arquivos NFS, a criação de um diretório correspondente ao nome do usuário no filesystem do NFS, a instalação e configuração do servidor Apache, a elaboração de um script para verificar a disponibilidade do serviço e enviar os resultados para o diretório NFS, e a configuração da execução automatizada do script a cada 5 minutos.

# Parte prática | Requisitos AWS:

### 1 - Gerar uma chave pública para acesso ao ambiente;
- [Com o console da AWS aberto, vamos pesquisar pelo serviço de EC2](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-39-11.png)
- [Rolar a barra lateral até a opção de Network & Security e selecionar a opção Key Pairs](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-44-37.png)
- [No canto superior direito clicar em Criar Key Pair](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-46-38.png)
- [Colocar um nome para a chave, selecionar o tipo RSA, no formato, selecionar .pem para Linux(ou .ppk para Windows)](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-52-53.png)
- [Clicar em Create Key Pair](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-55-02.png)
- [A AWS armazena somente a chave pública](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2012-01-21.png)
- [Será entregue via Download a chave privada. Guarde-a com segurança](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2012-01-21.png)


<details>
  <summary>Dica de Segurança - Chave Privada.</summary>
  Uma dica de segurança é alterar as permissões da chave privada apenas para o usuário, caso outro usuário esteja logado na máquina, este não conseguirá usá-la.
  Para isso basta abrir o terminal, localizar a chave e executar o comando:

  `chmod 400 nome_da_chave.pem`.

  No meu caso como sei que foi feito o Download via navegador, sei que está na pasta de Downloads
  Então vou abrir o terminal, digitar cd Downloads, para trocar o diretório para a pasta de Downloads
  Digitar ls para confirmar a presença e o nome da chave
  Antes da modificação, podemos verificar suas permissões com `ls -la`
  onde tem [permissões de escrita e leitura para dono e grupo e leitura para outros usuários](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2012-15-45.png)
  Digitando então o comando `chmod 400 AccessKey-Atividade_1_Compass.pem`
  Após a modificação podemos ver que [apenas o usuário dono da chave tem permissão de leitura agora](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2012-18-02.png)
</details>

### 2 - Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
- [No console da AWS, entrar no serviço de EC2](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2011-39-11.png)
- [No menu da esquerda clicamos em Instances](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-33-10.png)
- [No canto superior direito clicamos em Launch Instances](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-33-36.png)
- [No menu de Name e Tags, colocamos as Tags pertinentes ao projeto](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-35-46.png)
- [No menu de AMI, selecionamos o enunciado](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-38-37.png)
- [Em Instance type, selecionamos o tipo de máquina solicitado](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-39-55.png)
- [Em Key Pair, selecionamos o par de chaves criado anteriormente](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-40-48.png)
- [Em network settings, vou deixar marcado a VPC Padrão](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-48-51.png)
- [Vou criar um Security Group novo, pois posteriormente vou ter que abrir portas específicas para essa instância](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-48-51.png)
- [Em Configure Storage vamos selecionar o armazenamento requisitado](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-51-45.png)
- [Após configurar é só clicar no canto inferior direito em Launch Instance](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-51-45.png)
- [Aguardar conlcuir a inicialização e checks passed no status check da instância para poder utilizá-la](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/2%20-%20Instancia/Screenshot%20from%202024-02-01%2008-58-31.png)


### 3 - Gerar 1 elastic IP e anexar à instância EC2;
- [Na aba do lado esquerdo em EC2, descer até Network & Security e clicar em Elastic IPs](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/3%20-%20Elastic%20IP/Screenshot%20from%202024-02-01%2014-52-17.png)
- [No canto direito superior, clicar em Allocate Elastic Ip address](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/3%20-%20Elastic%20IP/Screenshot%20from%202024-02-01%2014-52-59.png)
- [Selecionar a região apropriada em Network Border Group e clicar em Allocate](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/3%20-%20Elastic%20IP/Screenshot%20from%202024-02-01%2014-53-35.png)
- [Após a alocação, selecionar o IP criado, clicar em actions e em seguida em Associate Elastic IP address](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/3%20-%20Elastic%20IP/Screenshot%20from%202024-02-01%2014-54-59.png)
- [Selecionar a Instância a ser anexada e clicar em Associate](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/3%20-%20Elastic%20IP/Screenshot%20from%202024-02-01%2014-56-22.png)

### 4 - Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP);
- [Para liberar as portas, clicamos em Security Groups no menu de Network & Security em EC2](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-00-06.png)
- [Irei selecionar o Security Group que criado junto com a instância](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-01-18.png)
- [Clicar na aba Inbound Rules e no botão Edito inbound rules](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-01-38.png)
- [Clicar em Add Rule para cada porta a ser liberada](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-02-25.png)
- [Selecionar o tipo de protocolo e as portas a serem liberadas e clica em Save Rules](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-40-10.png)
- [Um pequeno teste conectando na máquina via SSH pelo AWS CLI, provando que a porta 22 está liberada](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-45-05.png)


# Parte prática | Requisitos no Linux:

### 5 - Configurar o NFS entregue;
- [Para o NFS, usaremos o AWS EFS, pesquisar por EFS](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-28-36.png)
- [No canto direito superior, clicamos em Create file system](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-28-56.png)
- [Escolhemos um nome, a VPC e clicar em Create](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-30-07.png)
- [Selecionamos a EFS criada e clicamos em View details](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-32-19.png)
- [Vou clicar na aba network e no botão manage](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-33-20.png)
- [No menu Mount Targets, vou trocar o Security Group padrão pelo que criamos anteriormente, por já estar com a porta NFS liberada e clicar em Save](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-34-08.png)
- [Ao clicar em Attach, temos os comandos para anexar o NFS à uma instância.
Podemos usar via DNS com EFS helper, NFS client (que iremos usar) ou via IP](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-38-38.png)
- [Iremos, abrir o terminal e conectar em nossa instância via SSH para montar o NFS gerado](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-48-59.png)
- [No terminal iremos digitar]((https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-48-59.png)) `sudo su` [para permissões de root]((https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-48-59.png))
- [Vamos instalar na instância as dependências do EFS com o comando](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2015-52-49.png)
`sudo yum install -y amazon-efs-utils`
- [Criar um diretório onde será montado o NFS, vou chamá-lo de NFS-Atividade_1_Compass.
No terminal:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2016-27-53.png) `mkdir NFS-Atividade_1_Compass`
- [Agora vamos montar o nfs nessa pasta que criamos com o comando que nos foi passado anteriormente ao clicar em Attach.
Usando NFS cliente:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2016-30-45.png)
  ```
  sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 file_system_id.efs.aws-region.amazonaws.com:/ mount_point 
  ```
- [Vamos verificar a montagem do NFS com o 
comando](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-02%2016-32-13.png) `df -h`
- [Tudo ok. Vamos então colocar o comando para montar o NFS automaticamente quando a instância for iniciada. Para isso vamos editar o arquivo /etc/fstab:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-05%2008-29-24.png)
- Comandos: 

  `cd /etc`

  `sudo su`

  `vim fstab`
  
  Shift + A para inserir no final da linha e Enter para ir para a próxima linha
- Colar o código:
  ```
  file_system_id.efs.aws-region.amazonaws.com:/ mount_point nfs4 nfsvers=4.1,rsize=1048576wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0
  ```

- [Agora toda vez que a instância iniciar, o NFS será montado automaticamente.](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/5%20-%20Configurar%20NFS/Screenshot%20from%202024-02-05%2010-04-55.png)
- Observação: Substituir o file_system_id pelo id do seu NFS e o mount_point pelo diretório do seu ponto de montagem.

### 6 - Criar um diretorio dentro do filesystem do NFS com seu nome;
- [Com o NFS já montado, vamos digitar os seguintes comandos:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/6%20-%20Criar%20diretorio/Screenshot%20from%202024-02-02%2016-45-16.png)

  `cd NFS-Atividade_1_Compass` - Para mudar para o diretório onde foi criado o NFS

  `mkdir Wilton` - Para criar um diretório com seu nome

  `ls` - Para confirmar se o diretório foi criado com sucesso

### 7 - Subir um apache no servidor - o apache deve estar online e rodando;

- [Fazer a instalação do servidor apache na instância com os comandos:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2010-57-28.png)

  `sudo su`

  `yum install httpd -y`

- [Incializar e permitir que o servidor inicie automaticamente junto com a máquina:](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2010-58-19.png)

  `systemctl start httpd`

  `systemctl enable httpd`

- [Copiar o endereço IP público da Instância](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2011-00-14.png)
- [Colar o endereço IP na barra de endereço do navegador](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2011-02-05.png)

- [Com o comando a seguir, podemos ver que o servidor apache está configurado e incializado corretamente, pronto para ser personalizado.](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2011-04-59.png)

  `systemctl status httpd`

- [Servidor Personalizado](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/7%20-%20Subir%20apache/Screenshot%20from%202024-02-05%2011-04-59.png)

<details>
  <summary>Extra: Personalizando seu servidor apache.</summary>
  Baseado no index do apache, fiz uma página simples de HTML contendo esse repositório do github como link. 
  Vou mostrar como eu fiz.

  Entrar no diretório /var/www/html:

  `cd /var/www/html`

  Criar o arquivo index.html

  `vi index.html`

Código usado no meu Apache:

***Copiar e colar index.html***

PS: para adicionar ícones, colar os ícones desejados na pasta:
/usr/share/httpd/icons