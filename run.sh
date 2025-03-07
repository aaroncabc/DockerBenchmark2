#!/bin/bash

# Solicitar al usuario que ingrese el nombre del archivo que desea ejecutar
echo -n "ingresar el nombre del archivo que deseas ejecutar: "
read FILE

# Verificar si el archivo especificado existe en el directorio actual
if [[ ! -f "$FILE" ]]; then
    echo "Error: El archivo '$FILE' no se encuentra en el directorio actual."
    exit 1
fi

# Obtener la extensión del archivo
EXT="${FILE##*.}"

# Determinar el lenguaje de programación basado en la extensión del archivo
# y asignar el contenedor adecuado
case "$EXT" in
    py)
        IMAGE="python:3"  
        CMD="python3"     
        ;;
    java)
        IMAGE="openjdk:17"  
        CMD="javac $FILE && java -cp $(dirname $FILE) $(basename $FILE .java)"  
        ;;
    cpp|cc)
        IMAGE="gcc:latest"  
        CMD="g++ -o program $FILE && ./program"  
        ;;
    js)
        IMAGE="node:latest"  
        CMD="node"            
        ;;
    rb)
        IMAGE="ruby:latest"  
        CMD="ruby"            
        ;;
    *)
        echo "Error: La extensión '$EXT' no está soportada por este script."
        exit 1
        ;;
esac

# Mostrar mensaje indicando que se está ejecutando el archivo con su contenedor correspondiente
echo "Ejecutando '$FILE' usando la imagen '$IMAGE'..."

# tiempo de inicio de la ejecución
START_TIME=$(date +%s%3N)

# Ejecutar el archivo en el contenedor y capturar la salida
OUTPUT=$(docker run --rm -v "$PWD:/app" -w /app $IMAGE bash -c "$CMD $FILE" 2>&1)

# Obtener el código de salida del contenedor
EXIT_CODE=$?

# tiempo de finalización de la ejecución
END_TIME=$(date +%s%3N)

# tiempo total de ejecución en milisegundos
EXEC_TIME=$((END_TIME - START_TIME))

# Comprobar si la ejecución fue exitosa (código de salida 0)
if [[ $EXIT_CODE -ne 0 ]]; then
    #mostrar el mensaje de error
    echo "Error al ejecutar el programa:"
    echo "$OUTPUT"
    exit 1
else
    #mostrar la salida y el tiempo de ejecución
    echo "Salida del programa:"
    echo "$OUTPUT"
    echo "Tiempo total de ejecución: ${EXEC_TIME}ms"
fi
