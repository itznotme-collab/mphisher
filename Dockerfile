# MPHISHER Docker Image
# Versión: 1.0.0

FROM debian:latest

LABEL maintainer="TU_NOMBRE"
LABEL description="MPHISHER - Herramienta de phishing educativa"
LABEL version="1.0.0"

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    php \
    curl \
    unzip \
    git \
    wget \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /root/mphisher

# Copiar todos los archivos del proyecto
COPY . /root/mphisher/

# Dar permisos de ejecución
RUN chmod +x mphisher.sh install.sh

# Puerto por defecto
EXPOSE 8080

# Comando por defecto al iniciar el contenedor
CMD ["bash", "mphisher.sh"]
