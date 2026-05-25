#!/bin/bash

# ============================================
# MPHISHER - Launch Script
# Script auxiliar para lanzar mphisher
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Directorio base
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR/.."

clear
echo -e "${CYAN}"
echo "  ███╗   ███╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
echo "  ████╗ ████║██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "  ██╔████╔██║██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
echo "  ██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
echo "  ██║ ╚═╝ ██║██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
echo "  ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${YELLOW}           Launch Script${NC}"
echo ""

# Verificar que existe el script principal
if [[ ! -f "mphisher.sh" ]]; then
    echo -e "${RED}[-] Error: No se encontró mphisher.sh${NC}"
    echo -e "${YELLOW}[*] Asegúrate de ejecutar este script desde el directorio scripts/${NC}"
    exit 1
fi

echo -e "${GREEN}[+] Iniciando MPHISHER...${NC}"
echo ""

# Ejecutar script principal
bash mphisher.sh "$@"
