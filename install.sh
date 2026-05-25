#!/bin/bash

## MPHISHER - Installation Script
## Author: TU_NOMBRE
## Version: 1.0.0

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "  ███╗   ███╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
echo "  ████╗ ████║██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "  ██╔████╔██║██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
echo "  ██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
echo "  ██║ ╚═╝ ██║██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
echo "  ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${YELLOW}           Instalador de Dependencias${NC}"
echo ""

echo -e "${GREEN}[+] Verificando sistema...${NC}"

# Detectar sistema
if [ -d "/data/data/com.termux/files/home" ]; then
    echo -e "${CYAN}[*] Termux detectado${NC}"
    PKG="pkg"
else
    echo -e "${CYAN}[*] Sistema Linux detectado${NC}"
    if command -v apt &> /dev/null; then
        PKG="apt"
    elif command -v apt-get &> /dev/null; then
        PKG="apt-get"
    elif command -v pacman &> /dev/null; then
        PKG="pacman"
    elif command -v dnf &> /dev/null; then
        PKG="dnf"
    elif command -v yum &> /dev/null; then
        PKG="yum"
    else
        echo -e "${RED}[-] Gestor de paquetes no soportado${NC}"
        exit 1
    fi
fi

# Instalar dependencias
echo -e "${GREEN}[+] Instalando dependencias...${NC}"

PACKAGES="php curl"

for pkg in $PACKAGES; do
    if command -v $pkg &> /dev/null; then
        echo -e "${GREEN}[✓] $pkg ya está instalado${NC}"
    else
        echo -e "${YELLOW}[*] Instalando $pkg...${NC}"
        if [ "$PKG" = "pacman" ]; then
            sudo $PKG -S $pkg --noconfirm
        elif [ "$PKG" = "dnf" ] || [ "$PKG" = "yum" ]; then
            sudo $PKG install -y $pkg
        elif [ "$PKG" = "pkg" ]; then
            $PKG install -y $pkg
        else
            sudo $PKG install -y $pkg
        fi
    fi
done

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Instalación completada exitosamente!          ║${NC}"
echo -e "${GREEN}╠════════════════════════════════════════════════╣${NC}"
echo -e "${GREEN}║  Ahora puedes ejecutar: bash mphisher.sh       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
echo ""
