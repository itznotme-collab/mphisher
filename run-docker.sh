#!/bin/bash

# MPHISHER Docker Runner
# Ejecuta mphisher en un contenedor Docker

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}"
echo "  ███╗   ███╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
echo "  ████╗ ████║██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "  ██╔████╔██║██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
echo "  ██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
echo "  ██║ ╚═╝ ██║██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
echo "  ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${GREEN}  Docker Container Runner${NC}"
echo ""

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}[-] Docker no está instalado${NC}"
    echo -e "${YELLOW}[*] Instala Docker: https://docs.docker.com/get-docker/${NC}"
    exit 1
fi

# Nombre de la imagen
IMAGE_NAME="mphisher"
CONTAINER_NAME="mphisher-container"

echo -e "${CYAN}[*] Verificando imagen...${NC}"

# Construir imagen si no existe
if ! docker images | grep -q "^$IMAGE_NAME"; then
    echo -e "${YELLOW}[*] Construyendo imagen Docker...${NC}"
    docker build -t $IMAGE_NAME .
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}[-] Error al construir la imagen${NC}"
        exit 1
    fi
fi

# Detener contenedor anterior si existe
if docker ps -a | grep -q $CONTAINER_NAME; then
    echo -e "${YELLOW}[*] Deteniendo contenedor anterior...${NC}"
    docker stop $CONTAINER_NAME 2>/dev/null
    docker rm $CONTAINER_NAME 2>/dev/null
fi

# Crear directorio para datos persistentes
mkdir -p $(pwd)/auth

echo -e "${GREEN}[+] Iniciando MPHISHER en Docker...${NC}"
echo ""

# Ejecutar contenedor
docker run -it --rm \
    --name $CONTAINER_NAME \
    -p 8080:8080 \
    -p 4040:4040 \
    -v $(pwd)/auth:/root/mphisher/auth \
    $IMAGE_NAME
