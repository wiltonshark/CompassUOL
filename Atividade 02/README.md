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

Vejamos, o que vou precisar?

- Dúvida: "Efetuar Deploy de uma aplicação Wordpress com:container de aplicação RDS database Mysql"
Efetuar deploy na instância e usar apenas docker para mysql ou efetuar deploy de container wordpress e mysql e usar docker-compose? Testar e ver como configurar conexão do mysql no docker caso não for usar docker-compose no wordpress

1 - VPC

2 - Criar Security Groups (apenas do load balancer com saida pra internet, restante acesso interno)

3 - LoadBalancer com acesso aos usuários

4 - Availability Zone 1 e 2

5 - Criar template do ec2 (lembrar das tags)

5a - Instalação e configuração do DOCKER ou CONTAINERD no host EC2 (com mysql client?!-docker compose)

5b - Ponto adicional para o trabalho que utilizar a instalação via script de Start Instance (user_data.sh) - usar no template

5c - Um Ec2 Instance com Wordpress em cada AZ (Usar template ja com instalacao no userdata e auto escaling nos azs)

5d - Ambas EC2 conecado ao Amazon RDS MySQL
(Efetuar Deploy de uma aplicação Wordpress com:container de aplicação RDS database Mysql)

6 - Criar EFS

7 - configuração da utilização doserviço EFS AWS para estáticos do container de aplicação Wordpress

8 - Criação do Target Group

9 - Auto Scaling Group