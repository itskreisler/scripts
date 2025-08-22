#!/bin/bash
# Script kawaii para usar ntfy desde la terminal uwu nyaa~

# Valores por defecto
SERVER="https://ntfy.sh"
TOPIC="mi-topic"
FORMAT="raw"
HEADERS=()
DATA=""
ATTACH=""

# Mostrar ayuda
usage() {
  echo "Uso: $0 [opciones] {listen|send}"
  echo
  echo "Opciones:"
  echo "  -s, --server URL       Servidor ntfy (default: $SERVER)"
  echo "  -t, --topic TOPICS     Nombre(s) de topic, separados por coma (default: $TOPIC)"
  echo "  -f, --format MODE      raw o json (default: $FORMAT)"
  echo "  -H, --header HEADER    Header extra (puedes repetir varias veces)"
  echo "  -d, --data MENSAJE     Contenido del mensaje (si no se usa, se lee de stdin)"
  echo "  -a, --attach FILE      Archivo a enviar (usa Filename header y --upload-file)"
  echo
  echo "Ejemplos:"
  echo "  $0 listen -t prueba1,prueba2"
  echo "  $0 send -t prueba -d 'Hola desde script kawaii'"
  echo "  echo 'desde pipe' | $0 send -t prueba -H \"Title: Pipe\""
  echo "  $0 send -t prueba -H \"Priority: high\" -d 'Con headers extra'"
  echo "  $0 send -t prueba -a imagen.png -H \"Title: Foto adjunta\""
  echo "  $0 send -t prueba -H \"Attach: https://ejemplo.com/file.apk\""
}

# Parseo de parámetros
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--server)
      SERVER="$2"
      shift 2
      ;;
    -t|--topic)
      TOPIC="$2"
      shift 2
      ;;
    -f|--format)
      FORMAT="$2"
      shift 2
      ;;
    -H|--header)
      HEADERS+=("-H" "$2")
      shift 2
      ;;
    -d|--data)
      DATA="$2"
      shift 2
      ;;
    -a|--attach)
      ATTACH="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    listen|send)
      CMD="$1"
      shift
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift
      ;;
  esac
done

# Funciones
listen() {
  echo "🐾 Escuchando en $SERVER/$TOPIC/$FORMAT ..."
  curl -s "$SERVER/$TOPIC/$FORMAT"
}

send() {
  # Si no hay DATA ni ATTACH, intentamos leer de stdin
  if [ -z "$DATA" ] && [ -z "$ATTACH" ]; then
    if [ ! -t 0 ]; then
      DATA="$(cat -)"
    fi
  fi

  # Nueva validación: permite headers como Attach sin necesidad de -d o -a
  if [ -z "$DATA" ] && [ -z "$ATTACH" ] && [ ${#HEADERS[@]} -eq 0 ]; then
    echo "Uso: $0 send -d 'mensaje kawaii' (o stdin) o -a archivo o -H 'Attach: URL'"
    exit 1
  fi

  IFS=',' read -ra TOPICS <<< "$TOPIC"
  for t in "${TOPICS[@]}"; do
    echo "📤 Enviando a $SERVER/$t ..."
    if [ -n "$ATTACH" ]; then
      FILENAME=$(basename "$ATTACH")
      curl -s -X POST "${HEADERS[@]}" \
        -H "Filename: $FILENAME" \
        --upload-file "$ATTACH" \
        "$SERVER/$t"
    elif [ -n "$DATA" ]; then
      curl -s -X POST -d "$DATA" "${HEADERS[@]}" "$SERVER/$t"
    else
      curl -s -X POST "${HEADERS[@]}" "$SERVER/$t"
    fi
    echo
  done
}

# Ejecutar comandos
case "$CMD" in
  listen)
    listen
    ;;
  send)
    send
    ;;
  *)
    usage
    ;;
esac
