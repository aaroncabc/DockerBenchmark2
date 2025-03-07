# README - Script Bash para Ejecutar Código en Contenedores Docker  

## Descripción  
Este script en Bash permite ejecutar archivos de código en diferentes lenguajes de programación dentro de contenedores. Es útil para ejecutar código sin necesidad de instalar los entornos de desarrollo en la máquina local.  

## Lenguajes Soportados  
El script reconoce la extensión del archivo ingresado y selecciona automáticamente el contenedor Docker adecuado:  

| Extensión | Lenguaje | Imagen de Docker | Comando de Ejecución |
|-----------|---------|------------------|---------------------|
| `.py` | Python | `python:3` | `python3 <archivo>` |
| `.java` | Java | `openjdk:17` | `javac <archivo> && java <nombre_clase>` |
| `.cpp`, `.cc` | C++ | `gcc:latest` | `g++ -o program <archivo> && ./program` |
| `.js` | JavaScript | `node:latest` | `node <archivo>` |
| `.rb` | Ruby | `ruby:latest` | `ruby <archivo>` |

## Requisitos  
- Tener **Docker** instalado y en ejecución en el sistema.  
- Tener permisos suficientes para ejecutar **Docker** sin `sudo` (opcional).  

## Instalación  
1. Clonar o descargar el script en tu equipo.  
2. Asegurarte de que el script tiene permisos de ejecución:  
   ```bash
   chmod +x ejecutar_codigo.sh
   ```

## Uso  
1. Ejecuta el script en la terminal:  
   ```bash
   ./ejecutar_codigo.sh
   ```
2. Se te pedirá que ingreses el nombre del archivo fuente que deseas ejecutar.  
3. El script verificará si el archivo existe y detectará su extensión.  
4. Se usará la imagen de Docker adecuada para compilar y/o ejecutar el código.  
5. Se mostrará la salida del programa junto con el tiempo de ejecución en milisegundos.  

## Ejemplo de Ejecución  
```bash
$ ./ejecutar_codigo.sh
Por favor, ingresa el nombre del archivo que deseas ejecutar: ejemplo.py
Ejecutando 'ejemplo.py' usando la imagen de Docker 'python:3'...
Salida del programa:
Hola, mundo!
Tiempo total de ejecución: 12ms
```

## Errores Comunes  
- **"El archivo 'archivo.ext' no se encuentra en el directorio actual."**  
  - Verifica que el archivo existe y está en el mismo directorio donde ejecutas el script.  

- **"Error: La extensión 'ext' no está soportada por este script."**  
  - Asegúrate de ingresar un archivo con una extensión compatible.  

- **"Error al ejecutar el programa:" seguido de un mensaje de error.**  
  - Puede haber un error en el código fuente. Revisa el mensaje de error para más detalles.  

## Licencia  
Este script es de uso libre y abierto bajo la licencia MIT.