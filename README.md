
# Script de Atualização do e-SUS Atenção Primária (e-SUS APS)

Este script Bash foi desenvolvido para automatizar o processo de atualização do e-SUS Atenção Primária (e-SUS APS) em ambientes Linux. O e-SUS APS é uma plataforma do Ministério da Saúde do Brasil voltada para o registro e gerenciamento de informações relacionadas à Atenção Primária à Saúde.

## e-SUS Atenção Primária (e-SUS APS)

O e-SUS APS é uma iniciativa que visa informatizar o processo de trabalho nas Unidades Básicas de Saúde (UBS), proporcionando uma melhor gestão da informação, otimização do atendimento aos pacientes e aprimoramento do planejamento em saúde. Ele abrange desde o cadastro dos usuários até a gestão de procedimentos e ações realizadas nas UBS.

Para mais informações sobre o e-SUS APS, acesse [o site oficial](https://sisaps.saude.gov.br/esus/).

## Pré-requisitos

- **Linux**: Este script foi projetado para sistemas operacionais Linux, especialmente testado no Ubuntu.
- **curl**: O script depende do comando `curl` para baixar o arquivo JAR do e-SUS APS.
- **Java**: O script usa o comando `java` para instalar o arquivo JAR do e-SUS APS.

## Como Usar

 1. **Clone o Repositório**: Clone este repositório em seu ambiente.
   

    git clone https://github.com/SoftagonSistemas/e-SUS-APS/
       cd e-SUS-APS

 2. Execute o Script:

    chmod +x atualiza-e-sus-aps-jar.sh
    ./atualiza-e-sus-aps-jar.sh

>  Este comando tornará o script executável e iniciará o processo de
> atualização.

 3. Acompanhe a Saída do Script:

O script exibirá mensagens durante sua execução, indicando o progresso e eventuais erros encontrados.

 4. Verifique a Instalação:

Após a execução bem-sucedida, verifique se o e-SUS APS foi atualizado corretamente.

## Detalhes do Script
O script realiza as seguintes etapas:

 - Verifica se o comando lsof está instalado e, se não estiver, tenta   
   instalá-lo.
 - Verifica se a porta 8080 está em uso e, se estiver, tenta    encerrar
   o processo.
 - Baixa o arquivo JAR do e-SUS APS do site    oficial.
 - Instala o arquivo JAR automaticamente, respondendo à    pergunta
   interativa com "S".
 - Aguarda 15 minutos para garantir que a    instalação seja concluída.
 - Reinicia o sistema.

