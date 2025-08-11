#!/data/data/com.termux/files/usr/bin/bash

NOTIF_ID=12345

termux-notification \
  --id $NOTIF_ID \
  --title "Descargar Musica" \
  --content "De donde quieres descargar?" \
  --button1 "YouTube" \
  --button1-action "sh -c 'am startservice --user 0 \
    -n com.termux/com.termux.app.RunCommandService \
    -a com.termux.RUN_COMMAND \
    --es com.termux.RUN_COMMAND_PATH /data/data/com.termux/files/home/scripts/shortcuts/yt-dlp-termux.sh \
    --es com.termux.RUN_COMMAND_WORKDIR /data/data/com.termux/files/home \
    --ez com.termux.RUN_COMMAND_BACKGROUND false \
    --es com.termux.RUN_COMMAND_SESSION_ACTION 0'" \
  --button2 "Spotify" \
  --button2-action "sh -c 'am startservice --user 0 \
    -n com.termux/com.termux.app.RunCommandService \
    -a com.termux.RUN_COMMAND \
    --es com.termux.RUN_COMMAND_PATH /data/data/com.termux/files/home/scripts/shortcuts/zotify-download.sh \
    --es com.termux.RUN_COMMAND_WORKDIR /data/data/com.termux/files/home \
    --ez com.termux.RUN_COMMAND_BACKGROUND false \
    --es com.termux.RUN_COMMAND_SESSION_ACTION 0'" \
  --button3 "Cerrar" \
  --button3-action "termux-notification-remove $NOTIF_ID" \
  --ongoing
