#!/usr/bin/bash

archivo="index"

if [[ -f $archivo ]]; then
    # Leer el archivo línea por línea
    while IFS= read -r linea; do
        echo "Index version: $linea"

        ./mclr-cli vanilla "$linea"
        vanilla=$?

        if [ $vanilla -eq 0 ]; then
            ./mclr-cli download $linea --package "$linea.tar.gz" --no-client --main-file --path ".downloads"
        else
            ./mclr-cli download $linea --package "$linea.tar.gz" --no-client --main-file --meta "./.customs/$linea.json" --path ".downloads"
        fi
        gh release upload versions "$linea.tar.gz"
        rm "$linea.tar.gz"

    done < "$archivo"
else
    echo "El archivo no existe."
fi

rm -rf versions
rm -rf java
