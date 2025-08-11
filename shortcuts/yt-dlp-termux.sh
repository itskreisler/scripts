#!/data/data/com.termux/files/usr/bin/bash

# Selección de formato
json_output=$(termux-dialog radio -t "Elige formato kawaii" -v "mp3,wav,flac,video")
code=$(echo "$json_output" | jq -r '.code')
format=$(echo "$json_output" | jq -r '.text')

if [[ "$code" != "0" && "$code" != "-1" ]] || [[ -z "$format" || "$format" == "null" ]]; then
  echo "No seleccionaste ningún formato o cancelaste, abortando uwu~"
  toast danger "No seleccionaste formato o cancelaste"
  set -o history
  exit 1
fi

echo "Seleccionaste formato: $format"
toast info "Formato elegido: $format"

# Entrada URL
json_output=$(termux-dialog text -t "Pega la URL kawaii")
code=$(echo "$json_output" | jq -r '.code')
url=$(echo "$json_output" | jq -r '.text')

if [[ "$code" != "0" && "$code" != "-1" ]] || [[ -z "$url" || "$url" == "null" ]]; then
  echo "No pegaste URL o cancelaste, abortando nyaaa~"
  toast danger "No pegaste URL o cancelaste"
  set -o history
  exit 1
fi

echo "URL recibida: $url"
toast info "URL recibida correctamente"

# Entrada directorio salida
json_output=$(termux-dialog text -t "Directorio de salida kawaii" -i "$HOME/storage/shared/")
code=$(echo "$json_output" | jq -r '.code')
output_dir=$(echo "$json_output" | jq -r '.text')

if [[ "$code" != "0" && "$code" != "-1" ]] || [[ -z "$output_dir" || "$output_dir" == "null" ]]; then
  echo "No especificaste directorio de salida, usando $HOME/storage/shared/ por defecto nyaaa~"
  toast info "Usando carpeta por defecto"
  output_dir="$HOME/storage/shared/"
fi

# Si la ruta NO empieza con / la convertimos a absoluta dentro de $HOME/storage/shared
if [[ "$output_dir" != /* ]]; then
  output_dir="$HOME/storage/shared/$output_dir"
fi

# Validar si el directorio existe kawaii~
if [[ ! -d "$output_dir" ]]; then
  echo "Error: El directorio '$output_dir' no existe, abortando uwu~"
  toast danger "Directorio no existe"
  set -o history
  exit 1
fi

echo "Directorio de salida: $output_dir"
toast success "Directorio listo: $output_dir"

# Ejecuta el comando kawaii según formato
tudo ~/scripts/video/yt-dlp-dl "$url" "$output_dir" "--$format"
toast success "Descarga iniciada nyaaa~"

#read -p "Presiona Enter para salir..."
