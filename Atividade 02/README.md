## 📚 Documentação (Em Andamento)

Objetivo:

- Instalação e configuração do DOCKER ou CONTAINERD no host EC2;

- Ponto adicional para o trabalho utilizar a instalação via script de Start Instance (user_data.sh)

- Efetuar Deploy de uma aplicação Wordpress com: container de aplicação RDS database Mysql

- Configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress

- Configuração do serviço de Load Balancer AWS para a aplicação Wordpress

Pontos de atenção:

- Não utilizar ip público para saída do serviços WP (Evitem publicar o serviço WP via IP Público)
- Sugestão para o tráfego de internet sair pelo LB (Load Balancer Classic)
- Pastas públicas e estáticos do wordpress, sugestão de utilizar o EFS (Elastic File Sistem)
- Fica a critério de cada integrante usar Dockerfile ou Dockercompose;
- Necessário demonstrar a aplicação wordpress funcionando (tela de login)
- Aplicação Wordpress precisa estar rodando na porta 80 ou 8080;
- Utilizar repositório git para versionamento;

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Atividade%2002.png width=60% >

# | Parte prática |

### 1 - Criar uma VPC

- Neste primeiro passo vamos selecionar VPC e criar uma nova, incluindo a marcação do Nat Gateway durante o processo de criação. O Nat Gateway será utilizado para proporcionar conectividade à Internet para as instâncias privadas. Para isso, abra o menu de criação de VPC no seu console AWS > Create VPC > VPC and more > Number of Availability Zones = 2, Numbero of public subnets = 2, Number of private subnets = 2, NAT gateways = 1 per AZ.

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/VPC/vpc.png width=60%>

### 2 - Criar os Security Groups

[SG-PUBLIC](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/Security%20Groups/SG-PUBLIC.png) - do Load Balancer
| Tipo            | Protocolo | Porta | Origem    |
|-----------------|-----------|-------|-----------|
| HTTP            | TCP       | 80    | 0.0.0.0/0 |
| HTTPS           | TCP       | 443   | ::/0      |


[SG-PRIVATE](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/Security%20Groups/SG-PRIVATE.png) - das Instâncias EC2

| Tipo            | Protocolo | Porta | Origem    |
|-----------------|-----------|-------|-----------|
| HTTP            | TCP       | 80    | SG-PUBLIC |
| HTTPS           | TCP       | 443   | SG-PUBLIC |


[SG-EFS](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/Security%20Groups/SG-EFS.png) - para conexão do NFS
| Tipo            | Protocolo | Porta | Origem     |
|-----------------|-----------|-------|------------|
| NFS             | TCP       | 2049  | SG-PRIVATE |


[SG-RDS](https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/Security%20Groups/SG-RDS.png) - para conexão do banco de dados
| Tipo            | Protocolo | Porta | Origem     |
|-----------------|-----------|-------|------------|
| MYSQL/AURORA    | TCP       | 3306  | SG-PRIVATE |


3 - LoadBalancer com acesso aos usuários

4 - Availability Zone 1 e 2

5 - Criar template do ec2 (lembrar das tags)

5a - Instalação e configuração do DOCKER ou CONTAINERD no host EC2 (com mysql client?!-docker compose)

5b - Ponto adicional para o trabalho que utilizar a instalação via script de Start Instance (user_data.sh) - usar no template

5c - Um Ec2 Instance com Wordpress em cada AZ (Usar template ja com instalacao no userdata e auto escaling nos azs)

5d - Ambas EC2 conecado ao Amazon RDS MySQL
(Efetuar Deploy de uma aplicação Wordpress com:container de aplicação RDS database Mysql)

6 - Criar EFS

7 - configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress

8 - Criação do Target Group

9 - Auto Scaling Group

- Dúvida: "Efetuar Deploy de uma aplicação Wordpress com:container de aplicação RDS database Mysql"
Efetuar deploy na instância e usar apenas docker para mysql ou efetuar deploy de container wordpress e mysql e usar docker-compose? Testar e ver como configurar conexão do mysql no docker caso não for usar docker-compose no wordpress