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
