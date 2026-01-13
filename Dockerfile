# Image de base avec Java 25 (requis pour Hytale)
FROM eclipse-temurin:25-jdk-jammy

# Définir le répertoire de travail
WORKDIR /hytale

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Télécharger et installer le Hytale Downloader CLI
# Note: Vous devrez fournir un token OAuth2 pour télécharger les fichiers
# Alternative: copiez manuellement les fichiers Server/ et Assets.zip dans le conteneur
RUN wget -O hytale-downloader.zip https://downloader.hytale.com/hytale-downloader.zip && \
    unzip hytale-downloader.zip && \
    chmod +x hytale-downloader-linux-amd64 && \
    rm hytale-downloader.zip || true

# Créer un répertoire pour les données persistantes
RUN mkdir -p /hytale/data

EXPOSE 5520


# Volume pour les données persistantes
VOLUME ["/hytale/data"]

# Script de démarrage
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

