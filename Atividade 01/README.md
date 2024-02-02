## 📚 Documentação

Esta é a documentação do passo a passo do processo da atividade 1.

Os requisitos da atividade se encontram neste [PDF](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2001/PBD-Atividade%20de%20Linux%20-%20AWS%20-%20UNICESUMAR-290124-210439.pdf).

Parte prática | Requisitos AWS:

1 - Gerar uma chave pública para acesso ao ambiente;
- Com o console da AWS aberto, vamos pesquisar pelo serviço de EC2.
- Rolar a barra lateral até a opção de Network & Security e selecionar a opção Key Pairs.
- No canto superior direito clicar em Criar Key Pair
- Colocar um nome para a chave, selecionar o tipo RSA, no formato, selecionar .pem para Linux
- Clicar em Create Key Pair
- A AWS armazena somente a chave pública.
- Será entregue via Download a chave privada. Guarde-a com segurança.
Uma dica de segurança é alterar as permissões da chave privada apenas para o usuário, caso outro usuário esteja logado na máquina, este não conseguirá usá-la
Para isso basta abrir o terminal, localizar a chave e executar o comando:
chmod 400 nome_da_chave.pem

No meu caso como sei que foi feito o Download via navegador, sei que está na pasta de Downloads.
Então vou abrir o terminal, digitar cd Downloads, para trocar o diretório para a pasta de Downloads
Digitar ls para confirmar a presença e o nome da chave
Antes da modificação, podemos verificar suas permissões com ls -la
onde tem permissões de escrita e leitura para dono e grupo e leitura oara outros usuários
Digitando então o comando chmod 400 AccessKey-Atividade_1_Compass.pem
Após a modificação podemos ver que apenas o usuário dono da chave tem permissão de leitura agora.


2 - Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família
t3.small, 16 GB SSD);
- No console da AWS, entrar no serviço de EC2.
- No menu da esquerda clicamos em Instances
- No canto superior direito clicamos em Launch Instances
- No menu de Name e Tags, colocamos as Tags pertinentes ao projeto.
- No menu de AMI, selecionamos o enunciado
- Em Instance type, selecionamos o tipo de máquina solicitado
- Em Key Pair, selecionamos o par de chaves criado anteriormente
- Em network settings, vou deixar marcado a VPC Padrão
- Vou criar um Security Group novo, pois posteriormente vou ter que abrir portas específicas para essa instância.
- Em Configure Storage vamos selecionar o armazenamento requisitado.
- Após configurar é só clicar no canto inferior direito em Launch Instance.
- Aguardar conlcuir a inicialização e checks passed no status check da instância para poder utilizá-la.


3 - Gerar 1 elastic IP e anexar à instância EC2;
- Na aba do lado esquerdo em EC2, descer até Network & Security e clicar em Elastic IPs
- No canto direito superior, clicar em Allocate Elastic Ip address
- Selecionar a região apropriada em Network Border Group e clicar em Allocate
- Após a alocação, selecionar o IP criado, clicar em actions e em seguida em Associate Elastic IP address
- Selecionar a Instância a ser anexada e clicar em Associate

4 - Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e
UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).
- Para liberar as portas, clicamos em Security Groups no menu de Network & Security em EC2
- Irei selecionar o Security Group que criado junto com a instância
- Clicar na aba Inbound Rules e no botão Edito inbound rules
- Clicar em Add rule para cada porta a ser liberada
- Selecionar o tipo de protocolo e as portas a serem liberadas e clica em Save Rules

