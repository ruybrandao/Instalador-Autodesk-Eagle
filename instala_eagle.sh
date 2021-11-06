#!/usr/bin/env bash

# Remove arquivos compactados para instalação antigos
rm -f Autodesk_EAGLE*.tar.gz

# Baixa EAGLE compactado
echo "Baixando EAGLE..."
wget --user-agent="Mozilla" -q --show-progress --content-disposition https://www.autodesk.com/eagle-download-lin

# Variáveis
EAGLE=$(ls Autodesk_EAGLE*.tar.gz)                    # Nome do arquivo compactado
EAGLE_VER=$(echo $EAGLE | grep -Po "\d+\.\d+\.\d+")   # Versão do EAGLE
EAGLE_DESKTOP="$(xdg-user-dir DESKTOP)/EAGLE.desktop" # Caminho do atalho da área de trabalho
EAGLE_MENU="$HOME/.local/share/applications/" # Caminho do ícone

# Descompacta EAGLE
echo "Descompactando EAGLE..."
tar -xzf $EAGLE -C "$HOME/"

# Cria ícone na área de trabalho
echo "Criando ícones na área de trabalho e menu..."
echo "#!/usr/bin/env xdg-open

[Desktop Entry]
Version=$EAGLE_VER
Categories=Graphics
Type=Application
Terminal=false
Exec=env LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libxcb-dri3.so.0 $HOME/eagle-$EAGLE_VER/eagle
Name=Eagle
Comment=Eagle
Icon=$HOME/eagle-$EAGLE_VER/bin/eagle-logo.png
" > "$EAGLE_DESKTOP"  # Cria ícone na área de trabalho
mkdir -p "$EAGLE_MENU"
cp "$EAGLE_DESKTOP" "$EAGLE_MENU" # Cria ícone no menu
chmod +x "$EAGLE_DESKTOP"                        # Torna o atalho executável
gio set "$EAGLE_DESKTOP" "metadata::trusted" yes # Marca arquivo de atalho como confiável

