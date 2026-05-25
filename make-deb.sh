#!/bin/bash

# ============================================
# MPHISHER - Debian Package Builder
# Crea paquetes .deb para instalar en Debian/Ubuntu/Kali
# ============================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variables del paquete
PKG_NAME="mphisher"
VERSION="1.0.0"
ARCH="all"
MAINTAINER="TU_NOMBRE <tu_email@example.com>"
DESCRIPTION="MPHISHER - Herramienta de phishing educativa"
SECTION="misc"
PRIORITY="optional"
DEPENDS="php, curl, unzip"

# Directorios temporales
BUILD_DIR="deb_build"
DEB_DIR="$BUILD_DIR/$PKG_NAME"

clear
echo -e "${CYAN}"
echo "  ███╗   ███╗██████╗ ██╗  ██╗██╗███████╗██╗  ██╗███████╗██████╗ "
echo "  ████╗ ████║██╔══██╗██║  ██║██║██╔════╝██║  ██║██╔════╝██╔══██╗"
echo "  ██╔████╔██║██████╔╝███████║██║███████╗███████║█████╗  ██████╔╝"
echo "  ██║╚██╔╝██║██╔═══╝ ██╔══██║██║╚════██║██╔══██║██╔══╝  ██╔══██╗"
echo "  ██║ ╚═╝ ██║██║     ██║  ██║██║███████║██║  ██║███████╗██║  ██║"
echo "  ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${YELLOW}           Debian Package Builder${NC}"
echo ""

echo -e "${GREEN}[+] Iniciando construcción del paquete .deb...${NC}"
echo ""

# Limpiar build anterior
if [ -d "$BUILD_DIR" ]; then
    echo -e "${YELLOW}[*] Limpiando build anterior...${NC}"
    rm -rf "$BUILD_DIR"
fi

# Crear estructura de directorios
echo -e "${CYAN}[*] Creando estructura de directorios...${NC}"
mkdir -p "$DEB_DIR/usr/share/$PKG_NAME"
mkdir -p "$DEB_DIR/usr/bin"
mkdir -p "$DEB_DIR/usr/share/doc/$PKG_NAME"
mkdir -p "$DEB_DIR/usr/share/applications"
mkdir -p "$DEB_DIR/DEBIAN"

# Copiar archivos del proyecto
echo -e "${CYAN}[*] Copiando archivos...${NC}"

# Archivos principales
cp mphisher.sh "$DEB_DIR/usr/share/$PKG_NAME/"
cp install.sh "$DEB_DIR/usr/share/$PKG_NAME/"
cp README.md "$DEB_DIR/usr/share/$PKG_NAME/"
cp LICENSE "$DEB_DIR/usr/share/$PKG_NAME/"

# Directorio .sites
if [ -d ".sites" ]; then
    cp -r .sites "$DEB_DIR/usr/share/$PKG_NAME/"
fi

# Directorio .github (opcional)
if [ -d ".github" ]; then
    cp -r .github "$DEB_DIR/usr/share/$PKG_NAME/"
fi

# Crear script de lanzamiento en /usr/bin
echo -e "${CYAN}[*] Creando ejecutable...${NC}"
cat > "$DEB_DIR/usr/bin/$PKG_NAME" << 'EOF'
#!/bin/bash
cd /usr/share/mphisher
bash mphisher.sh "$@"
EOF
chmod +x "$DEB_DIR/usr/bin/$PKG_NAME"

# Crear archivo control
echo -e "${CYAN}[*] Generando archivo CONTROL...${NC}"
cat > "$DEB_DIR/DEBIAN/control" << EOF
Package: $PKG_NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: $MAINTAINER
Depends: $DEPENDS
Section: $SECTION
Priority: $PRIORITY
Description: $DESCRIPTION
 MPHISHER es una herramienta de phishing automatizada
 creada con fines educativos para demostrar cómo
 funcionan los ataques de phishing.
 .
 Esta herramienta debe usarse únicamente en entornos
 controlados y con fines de aprendizaje.
EOF

# Crear scripts de mantenimiento
echo -e "${CYAN}[*] Creando scripts de instalación...${NC}"

# Preinst - antes de instalar
cat > "$DEB_DIR/DEBIAN/preinst" << 'EOF'
#!/bin/bash
echo "Preparando instalación de MPHISHER..."
exit 0
EOF
chmod +x "$DEB_DIR/DEBIAN/preinst"

# Postinst - después de instalar
cat > "$DEB_DIR/DEBIAN/postinst" << 'EOF'
#!/bin/bash
echo "MPHISHER instalado correctamente!"
echo ""
echo "Uso:"
echo "  mphisher          - Ejecutar la herramienta"
echo "  mphisher --help   - Ver ayuda"
echo ""
exit 0
EOF
chmod +x "$DEB_DIR/DEBIAN/postinst"

# Prerm - antes de desinstalar
cat > "$DEB_DIR/DEBIAN/prerm" << 'EOF'
#!/bin/bash
echo "Desinstalando MPHISHER..."
exit 0
EOF
chmod +x "$DEB_DIR/DEBIAN/prerm"

# Postrm - después de desinstalar
cat > "$DEB_DIR/DEBIAN/postrm" << 'EOF'
#!/bin/bash
if [ "$1" = "purge" ]; then
    echo "Eliminando archivos de configuración..."
    rm -rf /usr/share/mphisher/auth 2>/dev/null
fi
exit 0
EOF
chmod +x "$DEB_DIR/DEBIAN/postrm"

# Crear archivo de copyright
echo -e "${CYAN}[*] Generando copyright...${NC}"
cat > "$DEB_DIR/usr/share/doc/$PKG_NAME/copyright" << EOF
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: $PKG_NAME
Source: https://github.com/TU_USUARIO/$PKG_NAME

Files: *
Copyright: 2024 TU_NOMBRE
License: GPL-3.0+

License: GPL-3.0+
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 .
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 .
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF

# Crear changelog
echo -e "${CYAN}[*] Generando changelog...${NC}"
cat > "$DEB_DIR/usr/share/doc/$PKG_NAME/changelog" << EOF
$PKG_NAME ($VERSION) unstable; urgency=medium

  * Versión inicial
  * Soporte para plantillas de phishing
  * Integración con Cloudflared
  * Interfaz de usuario mejorada

 -- $MAINTAINER  $(date -R)
EOF
gzip -9 "$DEB_DIR/usr/share/doc/$PKG_NAME/changelog"

# Crear md5sums
echo -e "${CYAN}[*] Generando checksums...${NC}"
cd "$DEB_DIR"
find usr -type f -exec md5sum {} \; > DEBIAN/md5sums
cd ../..

# Establecer permisos correctos
echo -e "${CYAN}[*] Ajustando permisos...${NC}"
chmod 755 "$DEB_DIR/DEBIAN"
find "$DEB_DIR/usr" -type d -exec chmod 755 {} \;
find "$DEB_DIR/usr" -type f -exec chmod 644 {} \;
chmod 755 "$DEB_DIR/usr/bin/$PKG_NAME"
chmod 755 "$DEB_DIR/usr/share/$PKG_NAME/mphisher.sh"
chmod 755 "$DEB_DIR/usr/share/$PKG_NAME/install.sh"

# Construir el paquete
echo -e "${GREEN}[+] Construyendo paquete .deb...${NC}"
dpkg-deb --build "$DEB_DIR"

# Verificar resultado
if [ $? -eq 0 ]; then
    # Mover paquete al directorio actual
    mv "$BUILD_DIR/${PKG_NAME}_${VERSION}_${ARCH}.deb" "./${PKG_NAME}_${VERSION}_${ARCH}.deb"
    
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  PAQUETE CREADO EXITOSAMENTE                  ║${NC}"
    echo -e "${GREEN}╠════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║  Archivo: ${PKG_NAME}_${VERSION}_${ARCH}.deb${NC}"
    echo -e "${GREEN}║  Tamaño: $(du -h "./${PKG_NAME}_${VERSION}_${ARCH}.deb" | cut -f1)${NC}"
    echo -e "${GREEN}╠════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║  Instalar con:                                ║${NC}"
    echo -e "${GREEN}║  sudo dpkg -i ${PKG_NAME}_${VERSION}_${ARCH}.deb${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Limpiar directorio temporal
    rm -rf "$BUILD_DIR"
    
    # Información adicional
    echo -e "${CYAN}[*] Información del paquete:${NC}"
    dpkg-deb -I "./${PKG_NAME}_${VERSION}_${ARCH}.deb"
else
    echo -e "${RED}[-] Error al construir el paquete${NC}"
    exit 1
fi
