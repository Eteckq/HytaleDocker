#!/bin/bash
set -e

cd /hytale


# Si les fichiers du serveur ne sont pas présents, lancer le téléchargement interactif
if [ ! -f "Server/HytaleServer.jar" ]; then
    echo "=========================================="
    echo "Fichiers du serveur non trouvés."
    echo "Lancement du Hytale Downloader..."
    echo "=========================================="
    echo ""
    echo "Vous allez devoir vous authentifier via OAuth2."
    echo "Suivez les instructions affichées par le downloader."
    echo ""
    
    /install/hytale-downloader-linux-amd64
    
    ZIP_FILE=$(find . -maxdepth 1 -name "*.zip" -type f | head -1)
    
    if [ -n "$ZIP_FILE" ]; then
        echo ""
        echo "Extraction du fichier téléchargé: $ZIP_FILE"
        unzip -q "$ZIP_FILE" -d .
        rm -f "$ZIP_FILE"
        echo "Fichiers extraits avec succès!"
    fi
    
    if [ ! -f "Server/HytaleServer.jar" ]; then
        echo ""
        echo "ERREUR: Server/HytaleServer.jar introuvable après le téléchargement."
        echo "Veuillez réessayer ou monter les fichiers manuellement."
        exit 1
    fi
    echo ""
fi

if [ -f "Server/HytaleServer.jar" ]; then
    SERVER_JAR="Server/HytaleServer.jar"
else
    echo "ERREUR: HytaleServer.jar introuvable!"
    exit 1
fi

ASSETS_PATH="${HYTALE_ASSETS_PATH:-Assets.zip}"
if [ ! -f "$ASSETS_PATH" ]; then
    # Chercher dans le répertoire parent
    if [ -f "../$ASSETS_PATH" ]; then
        ASSETS_PATH="../$ASSETS_PATH"
    else
        echo "AVERTISSEMENT: Assets.zip non trouvé. Le serveur pourrait ne pas démarrer correctement."
    fi
fi

echo "Démarrage du serveur Hytale..."
echo "JAR: $SERVER_JAR"
echo "Assets: $ASSETS_PATH"
echo ""

exec java -jar "$SERVER_JAR" --assets "$ASSETS_PATH"

