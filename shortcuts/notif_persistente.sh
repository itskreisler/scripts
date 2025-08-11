#!/data/data/com.termux/files/usr/bin/bash

NOTIF_ID=12345
YT_DLP_SCRIPT="$HOME/scripts/shortcuts/yt-dlp-termux.sh"
ZOTIFY_SCRIPT="$HOME/scripts/shortcuts/zotify-download.sh"

termux-notification \
  --id $NOTIF_ID \
  --title "Control Kawaii" \
  --content "Elige tu destino, nyaaa~" \
  --button1 "YouTube" \
  --button1-action "bash \"$YT_DLP_SCRIPT\"" \
  --button2 "Spotify" \
  --button2-action "bash \"$ZOTIFY_SCRIPT\"" \
  --button3 "Cerrar" \
  --button3-action "termux-notification-remove $NOTIF_ID" \
  --ongoing
