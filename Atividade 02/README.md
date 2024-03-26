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

# | --- Parte prática --- |

## 1 - Criar uma VPC

- Neste primeiro passo vamos selecionar VPC e criar uma nova, incluindo a marcação do Nat Gateway durante o processo de criação. 
- O Nat Gateway será utilizado para proporcionar conectividade à Internet para as instâncias privadas.
- Para isso, abra o menu de criação de VPC no seu console AWS -> Create VPC -> VPC and more -> Number of Availability Zones = 2, Numbero of public subnets = 2, Number of private subnets = 2, NAT gateways = 1 per AZ.

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/VPC/VPC.png width=60%>

## 2 - Criar os Security Groups

- Neste passo, vamos no menu de EC2 -> Network & Security ou VPC -> Security, Security Group -> Create Security Group e criar os grupo as seguir com seus protocolos e origem:

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

## 3 - Criar o EFS

- Neste passo, vamos criar um EFS para utilização das pastas públicas e estáticos do wordpress, do container de aplicação Wordpress. Vamos em EFS -> Create File System.
- Selecionar a VPC criada, as subnets privadas e o Security Group do EFS.

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/EFS/EFS.png width=60%>


## 4 - Criar o RDS

- Neste passo, vamos criar o banco de dados para o container de aplicação RDS database Mysql.
- Vamos em Amazon RDS -> Dashboard -> Create database.
- Selecionar MySQL, Template = Free Tier.
- Criar username e password, selecionar o tipo de instância e storage.
- Como não criei o template das instâncias ainda, vou selecionar em não conectar à uma instância EC2.
- Não selecionar acesso público!
- Selecionar a VPC e o Security Group criados.
- Criar um nome inicial do Database.

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/RDS/RDS.png width=60%>


## 5 - Criar o Template da Instância

- Como vamos trabalhar com auto scaling, é essencial criar um template já com os detalhes do que vamos querer instalar na imagem.
- Imagina ter que configurar manualmente toda instância que sobe quando o workload aumenta? Seria muito oneroso.
- Para isso iremos em EC2 -> Launch Templates -> Create launch template.

- Vamos criar uma instância Amazon Linux t3.small, criar uma chave SSH, conectá-la ao security group SG-PRIVATE, colocar as tags pertinentes ao PB e incluir o user_data.sh para instalar o docker, wordpress, nfs-utils, montar o efs e criar o yaml para conectar ao rds.

<details>
  <summary>user_data.sh</summary>

  ```
  #!/bin/bash
  sudo su
  yum update -y
  yum install docker -y
  systemctl start docker
  systemctl enable docker
  usermod -aG docker ec2-user
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  mv /usr/local/bin/docker-compose /bin/docker-compose
  yum install nfs-utils -y
  mkdir /mnt/efs/
  chmod +rwx /mnt/efs/
  mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ID_DO_SEU_EFS.efs.us-east-1.amazonaws.com:/ /mnt/efs
  echo "ID_DO_SEU_EFS.efs.us-east-1.amazonaws.com:/ /mnt/efs nfs defaults 0 0" >> /etc/fstab
  echo "version: '3.8'
  services:
    wordpress:
      image: wordpress:latest
      volumes:
        - /mnt/efs/wordpress:/var/www/html
      ports:
        - 80:80
      restart: always
      environment:
        WORDPRESS_DB_HOST: ENDPOINT DO SEU RDS
        WORDPRESS_DB_USER: MASTER USERNAME DO SEU RDS
        WORDPRESS_DB_PASSWORD: MASTER PASSWORD DO SEU RDS
        WORDPRESS_DB_NAME: INITIAL NAME DO SEU RDS
        WORDPRESS_TABLE_CONFIG: wp_" | sudo tee /mnt/efs/docker-compose.yml
  cd /mnt/efs && sudo docker-compose up -d
  ```
</details>

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/Template/Template.png width=60%>

## 6 - Criar o Target Group

- O Target Group serve para dizer ao Load Balancer quais Instâncias ele vai conectar
- Para isso vamos em EC2 -> Load Balancing -> Target Groups -> Create target froup
- Selecionar o tipo Instances, protocolo HTTP, selecionar a VPC criada, como o auto scaling ainda não foi criado, não há instâncias para selecionar, vamos deixar assim por enquanto.

<img src=https://github.com/wiltonshark/CompassUOL/blob/main/Atividade%2002/Prints/TargetGroup/TargetGroup.png width=60%>

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
- Configuração da utilização do serviço EFS AWS para estáticos do container de aplicação Wordpress - CONTAINER!!! melhor o docker compose então.