## 📚 Documentação

[Documentação](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/PBD-Atividade%20de%20Linux%20-%20AWS%20-%20UNICESUMAR-290124-210439.pdf)

Parte prática | Requisitos AWS:

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

  chmod 400 nome_da_chave.pem.

  No meu caso como sei que foi feito o Download via navegador, sei que está na pasta de Downloads
  Então vou abrir o terminal, digitar cd Downloads, para trocar o diretório para a pasta de Downloads
  Digitar ls para confirmar a presença e o nome da chave
  Antes da modificação, podemos verificar suas permissões com ls -la
  onde tem [permissões de escrita e leitura para dono e grupo e leitura para outros usuários](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/1%20-%20Chave%20Publica/Screenshot%20from%202024-01-31%2012-15-45.png)
  Digitando então o comando chmod 400 AccessKey-Atividade_1_Compass.pem
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
- [Clicar em Add rule para cada porta a ser liberada](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-02-25.png)
- [Selecionar o tipo de protocolo e as portas a serem liberadas e clica em Save Rules](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-40-10.png)
- [Um pequeno teste conectando na máquina via SSH pelo AWS CLI, provando que a porta 22 está liberada](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/Prints/4%20-%20Portas/Screenshot%20from%202024-02-01%2015-45-05.png)
