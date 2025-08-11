#!/data/data/com.termux/files/usr/bin/bash

# Pedir URL con dialog kawaii
json_output=$(termux-dialog text -t "Pega la URL kawaii para zotify uwu~")
code=$(echo "$json_output" | jq -r '.code')
url=$(echo "$json_output" | jq -r '.text')

if [[ "$code" != "0" && "$code" != "-1" ]] || [[ -z "$url" || "$url" == "null" ]]; then
  echo "No pegaste URL o cancelaste, abortando nyaaa~"
  toast danger "Cancelado o sin URL :c nyaaa~"
  exit 1
fi

echo "Ejecutando zotify kawaii uwu~ en proot-distro Ubuntu..."
toast info "Ejecutando zotify kawaii uwu~"

# Ejecutar el comando dentro de proot-distro activando venv
proot-distro login ubuntu -- /bin/bash -c "
source /root/zotify-project/venv-zotify/bin/activate && \
zotify --album-library=\"/data/data/com.termux/files/home/storage/shared/zotify/\" --output-album \"{album_artist}.{album}.{track_number}. {artists} - {title}\" --ffmpeg-args \"-b:a 320k\" --download-quality high --audio-format mp3 \"$url\"
"
toast info "Proceso terminado uwu~"
#read -p "Presiona Enter para salir... nyaaa~"
