#!/usr/bin/bash

archivo="index"

if [[ -f $archivo ]]; then
    # Leer el archivo línea por línea
    while IFS= read -r linea; do
        echo "Index version: $linea"

	./mclr $linea
	
	 gh release upload versions "$linea.tar.gz"
	 rm "$linea.tar.gz"

    done < "$archivo"
else
    echo "El archivo no existe."
fi

rm -rf versions
rm -rf java
