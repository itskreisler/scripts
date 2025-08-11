# Mis scripts kawaii
# Scripts en Termux

Este repositorio contiene mis scripts organizados para usarlos facilmente en Termux.

## Estructura

```bash
~/scripts/
    script1.sh
    script2.sh
    ...
```

## Como enlazar scripts a un directorio global

Para que puedas ejecutar tus scripts desde cualquier lugar sin escribir la ruta completa, puedes crear enlaces simbolicos en un directorio que este en tu PATH.

### Pasos

1. Crea una carpeta para tus scripts si no existe:
```bash
mkdir -p ~/scripts
```

2. Mueve tus scripts a esa carpeta y asegurate de darles permisos de ejecucion:
```bash
mv mi_script.sh ~/scripts/
chmod +x ~/scripts/mi_script.sh
```

3. Crea un directorio bin local si no existe:
```bash
mkdir -p ~/bin
```

4. Enlaza el script desde `~/scripts` a `~/bin`:
```bash
ln -s ~/scripts/mi_script.sh ~/bin/mi_script
```

5. Agrega `~/bin` a tu PATH en tu `~/.bashrc` o `~/.zshrc`:
```bash
export PATH="$HOME/bin:$PATH"
```

6. Recarga tu shell:
```bash
source ~/.bashrc
```

Ahora puedes ejecutar `mi_script` desde cualquier lugar.

## Subir cambios a GitHub

1. Agregar cambios:
```bash
git add .
```

2. Commit:
```bash
git commit -m "Agregue nuevo script"
```

3. Subir cambios:
```bash
git push origin main
```

Listo uwu.

## Ejemplo extra de enlace rápido

Puedes verificar si un script no tiene un enlace y crearlo automáticamente:

command -v speech2text > /dev/null || ln -s "$(pwd)/speech2text" "$HOME/../usr/bin/speech2text"

Ejemplo individual para speech2text:
```bash
command -v speech2text > /dev/null || ln -s "$(pwd)/speech2text" "$HOME/../usr/bin/speech2text"
```

Ejemplo para enlazar todos los scripts de la carpeta:
```bash
for file in ~/scripts/*; do
    [ -f "$file" ] && command -v "$(basename "$file")" > /dev/null || ln -s "$file" "$HOME/../usr/bin/$(basename "$file")"
done
```

## 📂 Gestión de enlaces simbólicos para scripts
En Termux, podemos crear enlaces simbólicos en `$PREFIX/bin` para ejecutar nuestros scripts desde cualquier carpeta sin poner la ruta completa.

**Crear enlace simbólico si no existe:**
```bash
command -v grabar > /dev/null || ln -s "$(pwd)/grabar" "$HOME/../usr/bin/grabar"
```

**Eliminar enlace simbólico:**
```bash
rm "$HOME/../usr/bin/grabar"
```

**Verificar si existe el enlace y su destino:**
```bash
ls -l "$HOME/../usr/bin/grabar"
```

**Comando para crear o borrar automáticamente según exista o no:**
```bash
if [ -L "$HOME/../usr/bin/grabar" ]; then
    rm "$HOME/../usr/bin/grabar" && echo "Enlace eliminado"
else
    ln -s "$(pwd)/grabar" "$HOME/../usr/bin/grabar" && echo "Enlace creado"
fi
```

## Organización y shortcuts en Termux 🐱‍👤✨

- Los scripts están organizados en la carpeta `scripts/` dentro del repo para mantener todo ordenadito y evitar tener archivos sueltos.

- Los shortcuts para Termux Widget están en `scripts/shortcuts/` y se copian directamente a la carpeta `~/.shortcuts` para que el widget los reconozca correctamente.

- Importante usar el shebang correcto para Termux en los scripts, por ejemplo:
 
```bash
#!/data/data/com.termux/files/usr/bin/bash
```

- Para ejecutar scripts que requieren entorno Termux correctamente, se usa la utilidad `tudo` para evitar errores de "cannot execute: required file not found".

- En los shortcuts que llaman a scripts del repo se recomienda usar la línea:

```bash
tudo ~/scripts/shortcuts/yt-dlp-launcher "$@"
```

- Siempre dar permisos de ejecución con `chmod +x` a los scripts y shortcuts para que funcionen con Termux Widget.

- Si el shortcut usa comandos de `termux-api`, se recomienda probar primero desde Termux normal para asegurarse que funcionan.

- Para manejar el historial al probar comandos se puede desactivar temporalmente con:  

```bash
set +o history
# comandos kawaii...
set -o history
```

#como ejecutar comandos desde una norificacion

```bash
termux-notification \
  --title "Abrir sesión uwu~" \
  --content "Tap aquí para ejecutar comando nya~" \
  --button1 "Ejecutar" \
  --button1-action "sh -c 'am startservice --user 0 \
    -n com.termux/com.termux.app.RunCommandService \
    -a com.termux.RUN_COMMAND \
    --es com.termux.RUN_COMMAND_PATH /data/data/com.termux/files/usr/bin/termux-dialog \
    --esa com.termux.RUN_COMMAND_ARGUMENTS -t,text,-i,\"Hola desde termux-dialog nya~\" \
    --es com.termux.RUN_COMMAND_WORKDIR /data/data/com.termux/files/home \
    --ez com.termux.RUN_COMMAND_BACKGROUND false \
    --es com.termux.RUN_COMMAND_SESSION_ACTION 0'"
```

## tambien oiedes ejecutar un script directamente que haga todo

```bash
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
    --es com.termux.RUN_COMMAND_PATH /data/data/com.termux/files/home/scripts/shortcuts/yt-dlp-t
ermux.sh \
    --es com.termux.RUN_COMMAND_WORKDIR /data/data/com.termux/files/home \
    --ez com.termux.RUN_COMMAND_BACKGROUND false \
    --es com.termux.RUN_COMMAND_SESSION_ACTION 0'" \
  --button2 "Spotify" \
  --button2-action "sh -c 'am startservice --user 0 \
    -n com.termux/com.termux.app.RunCommandService \
    -a com.termux.RUN_COMMAND \
    --es com.termux.RUN_COMMAND_PATH /data/data/com.termux/files/home/scripts/shortcuts/zotify-d
ownload.sh \
    --es com.termux.RUN_COMMAND_WORKDIR /data/data/com.termux/files/home \
    --ez com.termux.RUN_COMMAND_BACKGROUND false \
    --es com.termux.RUN_COMMAND_SESSION_ACTION 0'" \
  --button3 "Cerrar" \
  --button3-action "termux-notification-remove $NOTIF_ID" \
  --ongoing
```
