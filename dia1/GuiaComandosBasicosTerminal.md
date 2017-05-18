![banner](https://github.com/microgenomics/Workshop-PUC/blob/master/images/logocbibhorizontal.png?raw=true)

### Microbial Genomics Lab

---

## Guía de Comandos Básicos

La siguiente tabla contiene todos los comandos básicos que necesitas saber para navegar por la terminal. Está pensada para usuarios que usan la terminal por primera vez, mantenla a la vista mientras trabajas... muy pronto los memorizarás todos!

| Comando | ¿Para qué sirve? |
|:-------:|------------------|
|`cd folder/`|Entrar a la carpeta "folder"| 
|`cd ..`|Salir de la carpeta actual|
|`cd`|Salir de todas las carpetas
|`pwd`|¿Cuál es la ruta hasta la carpeta en la que estoy ahora?|
|`ls`|Muestra todos los archivos en la carpeta actual|
|`ls -1`|Muestra todos los archivos en la carpeta actual en forma de lista vertical|
|`ls -lhrt`|Muestra todos los archivos en la carpeta actual en forma de lista vertical, ordenados por fecha de última modificación, además del tamaño de cada uno|
|`ls *ejemplo.txt`|Muestra todos los archivos en la carpeta que terminen en "ejemplo.txt" (puedes reemplazar "ejemplo.txt" por lo que que quieras para personalizar tu búsqueda) - el `*` es el comodín de la terminal|
|`du -h folder/`|Muestra el tamaño (número y unidad) de la carpeta "folder"|
|`mkdir name/`| Crear la carpeta "folder"|
|`cp file folder/`|Copiar el archivo "file" a la carpeta "folder"|
|`cp file hello`|Replicar el archivo "file" en un nuevo archivo llamado "hello"|
|`mv file folder/`|Mueve el archivo "file" a la carpeta "folder"|
|`mv file ../`|Mueve el archivo "file" a la carpeta anterior| 
|`mv file hello`|Renombra el archivo "file" a "hello"|
|`rm file`|Eliminar el archivo "file"|
|`rm -r folder`|Eliminar la carpeta "folder"|
|`head file`|Ver las primeras 10 líneas del archivo "file"|
|`head -n # file`|Ver las primeras # líneas del archivo "file"|
|`tail file`|Ver las últimas 10 líneas del archivo "file"|
|`tail -n # file`|Ver las últimas # líneas del archivo "file"|
|`cat file`|Ver el archivo "file" completo|
|`cat file1 file2 file3 > file4`|Fusionar archivos "file1", "file2" y "file3" en un nuevo archivo "file4" (*imprimir el contenido de cada archivo uno abajo del otro en un archivo nuevo*)|
|`grep 'keyword' file`|Buscar "keyword" en el archivo "file" e imprimir la o las línea o líneas en la que se encuentra "keyword" (puedes reemplazar "keyword" por lo que tu quieras para personalizar tu búsqueda)|
|`grep 'keyword' -c file`|Muestra cuántas veces está "keyword" en el archivo "file" (puedes reemplazar "keyword" por lo que tu quieras para personalizar tu búsqueda)|

En la siguiente tabla encontrarás los comandos básicos para **crear** y **editar** archivos de texto plano usando el commando `vi`:

| Comando | ¿Para qué sirve? |
|:-------:|------------------|
|`vi name`|Crear o abrir el archivo "name" - crea si el archivo "name" no existe - abre si el archivo "name" existe|
|`i`|Entrar al editor (ahora puedes editar tu archivo)|
|`esc`|Salir del editor|
|`:wq`|Guardar los cambios y salir del archivo|
|`:q!`|Salir del archivo sin guardar los cambios|

...para conocer más comandos para editar en `vi` haz clic [aquí](http://www.radford.edu/~mhtay/CPSC120/VIM_Editor_Commands.htm).

Los archivos comprimidos son utilizados frecuentemente porque nos permiten transportar archivos de forma mas fácil y rapida. En la siguiente tabla encontrarás comandos básicos para descomprimir algunos de los formatos mas frecuentes:

| Formato | Comando para descomprimir |
|:-------:|:-------------------------:|
|`.zip`|`unzip file.zip`|
|`.gz`|`gzip -d file.gz`|
|`.tar.gz`|`tar -xzvf file.tar.gz`|
|`.tar`|`tar -xvf file.tar`|

