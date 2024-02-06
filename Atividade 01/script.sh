#!/bin/bash
# Script que verifica o status do serviço httpd e salva o resultado em um arquivo no diretório /home/ec2-user/NFS-Atividade_1_Compass/Wilton

DATA=$(date +%d/%m/%Y)
HORA=$(date +%H:%M:%S)
SERVICO="httpd"
STATUS=$(systemctl is-active $SERVICO)

if [ $STATUS == "active" ]; then
    MENSAGEM="O $SERVICO está ONLINE"
    echo "$DATA $HORA - $SERVICO - active - $MENSAGEM" >> /home/ec2-user/NFS-Atividade_1_Compass/Wilton/online.txt
else
    MENSAGEM="O $SERVICO está offline"
    echo "$DATA $HORA - $SERVICO - inactive - $MENSAGEM" >> /home/ec2-user/NFS-Atividade_1_Compass/Wilton/offline.txt

fi