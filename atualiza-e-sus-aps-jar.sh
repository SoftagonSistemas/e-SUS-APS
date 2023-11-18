#!/bin/bash

# Verificar se o lsof está instalado
if ! command -v lsof &> /dev/null; then
    echo "lsof não está instalado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y lsof
fi

# URL do site
url="https://sisaps.saude.gov.br/esus/"

# Diretório de destino
download_dir="/opt/e-SUS/download"

# Porta a ser verificada
port_to_check=8080

# Criar o diretório se não existir
mkdir -p "$download_dir"

# Verificar se a porta está em uso
if ss -tln | grep -q ":$port_to_check"; then
    echo "A porta $port_to_check já está em uso. Encerrando o processo..."

    # Encontrar o PID do processo usando a porta 8080
    pid=$(sudo lsof -i :$port_to_check -t)

    # Verificar se o PID foi encontrado
    if [ -n "$pid" ]; then
        echo "Encerrando o processo com PID $pid..."
        sudo kill -9 $pid
    else
        echo "Não foi possível determinar o PID do processo."
    fi
fi

# Obter o conteúdo da página
page_content=$(curl -s $url)

# Extrair o URL do arquivo jar que termina com Linux64.jar
jar_url=$(echo $page_content | grep -oP 'https://[^"]*Linux64\.jar')

# Verificar se o URL foi encontrado
if [ -z "$jar_url" ]; then
    echo "Erro: Não foi possível encontrar o URL do arquivo jar."
    exit 1
fi

# Obter o nome do arquivo a partir do URL
file_name=$(basename $jar_url)

# Caminho completo do arquivo no diretório de download
full_path="$download_dir/$file_name"

# Verificar se o arquivo já existe e substituir, se necessário
if [ -e "$full_path" ]; then
    echo "O arquivo já existe. Substituindo..."
fi

# Fazer o download do arquivo jar
curl -L -o "$full_path" $jar_url

# Verificar se o download foi bem-sucedido
if [ -s "$full_path" ]; then
    echo "Download concluído."

    # Instalar o arquivo jar respondendo automaticamente à pergunta interativa
    echo "S" | sudo java -jar "$full_path" -console -url="jdbc:postgresql://srv-captain--esus-araripina-postgres:5432/esusabararipina" -username="esusabarari" -password="bf3249f26fb9c8a9"

    # Aguardar 15 minutos
    echo "Aguardando 15 minutos..."
    sleep 900  # 900 segundos = 15 minutos

    # Reiniciar o sistema
    echo "Reiniciando o sistema..."
    sudo reboot
else
    echo "Erro: Falha ao baixar o arquivo jar."
    exit 1
fi
