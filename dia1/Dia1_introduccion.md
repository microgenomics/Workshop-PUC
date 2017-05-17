![banner](../images/logocbibhorizontal.png)
# Introducción a la Terminal y R.
--------
Hola!, bienvenidos al primer práctico de uso de terminal y R, aquí aprenderás los comandos esenciales usados en la terminal (o consola de comandos, o shell), y que son la base en el manejo de cualquier proyecto que tenga bioinformática en él. Así que... manos a la obra!.

**Recordatorio: Nunca escribas variables, nombres de archivo o de carpetas con ESPACIOS o ACENTOS. Los espacios y acentos son enemigos naturales de las terminales.**

## ¿Qué es una Terminal?

|	<img src="../images/terminal.png" alt="alt text" width="150"> | <img src="../images/terminal2.ico" alt="alt text" width="100">	| <img src="../images/terminal3.jpg" alt="alt text" width="200"> | <img src="../images/terminal4.jpg" alt="alt text" width="200"> |
|:-:|:-:|:-:|:-:|
|Esta es una terminal| Esta también es una terminal| Esto es la matrix, se hacen cosas parecidas en bioinformática, así que consideremos esta una terminal también| Esto es un ramsomware, el virus que atacó a Movistar hace unos días, hecho para windows, esto **no** es una terminal.|

Una terminal es un intérprete de comandos fundamental en los sistemas operativos para la interacción con el usuario, ya que, se escriben comandos y acciones en él. Realizar acciones seguidas en una terminal también es considerado programar, en cierta forma podemos ser hackers. En este practico solo nos concentraremos en las terminales basadas en Unix (Linux o Mac, los siento Windows esta vez no).

## ¿Qué puedo hacer con la terminal?
Prácticamente todo lo que hace un computador, con una terminal tu ordenas lo que quieres y el computador lo hará, lo difícil es transmitir lo que realmente pensamos a la terminal.

## Primeras ordenes
Cuando se aprende un nuevo lenguaje de programación, lo tradicional es hacer que el computador nos diga "Hola Mundo" en dicho lenguaje de programación. Así que el primer paso abrir una terminal como esta:
![](../images/openterminal.png)
ahora usaremos el comando "echo" para que la terminal nos diga lo que queremos así que escribiremos: echo "Hola Mundo" y presionamos enter.
![](../images/hellow.png)
En realidad podemos decirle al computador que nos diga cualquier cosa con el comando echo, recuerda que cada vez que ingresas un comando o acción debes presionar enter.
## Variables
En la terminal podemos asignar frases completas (o números), a variables, y no nos referimos a variables matemáticas X e Y (podemos hacerlo, pero no es entretenido). **recuerda siempre poner tus variables dentro de comillas dobles**
![](../images/despacito.png)
y ahora en la misma terminal, podemos decirle al computador que nos muestre los párrafos con el comando echo y darle las variables como parámetro. **Cuando queremos hacer referencia a una variable la escribimos anteponiendo un "$"**: 

	echo $variable1, $variable2, $variable3, $variable4
	Despacito, Quiero respirar tu cuello despacito, Deja que te diga cosas al oído, Para que te acuerdes si no estás conmigo
	
## Manejando directorios
La terminal no solo sirve para realizar operaciones como una calculadora o hacer que escriba una canción, también es frecuentemente usado para manipular directorios, el primer paso en el uso de estos, es la creación de una carpeta, para ello el comando a usar se llama **mkdir**:

	mkdir dia1
	esto creará una carpeta llamada dia1

Para entrar a nuestra carpeta recién creada, usaremos el comando **cd**:

	cd dia1

Solo con esto se siente un poco vacío lo que hacemos, y en realidad podría necesitar un poco mas de información acerca de la "ruta completa", para ello usaremos el comando **pwd**

	pwd
	/Users/castrolab04/Desktop/Workshop-PUC/dia1
	esto es una ruta completa, nosotros estamos posicionados en la última carpeta llamada dia1 (cada / separa una carpeta dentro de otra).
	No te preocupes si no se muestra la misma ruta, de hecho, es probable que la ruta sea única para cada computador.
	
ya sabemos donde estamos en nuestra terminal, ahora listemos los archivos en la carpeta usando el comando **ls**:

	ls
	Dia1_introduccion.md
	
	si nuestra carpeta esta vacía, no mostrará nada, de lo contrario mostrara todos los archivos y carpetas que estén allí.
	si queremos ver los archivos con más información podemos agregar parámetros a ls como lo son -lh (long format in human readble format)
	
	ls -lh
	total 1
	-rw-r--r--  1 castrolab04  staff    12K May 17 11:49 Dia1_introduccion.md

	las primeras lineas y guiones hacen referencia a los permisos que tiene el archivo sobre el sistema (no nos preocuparemos de eso)
	1 castrolab04 staff es la cantidad de usuarios y grupos (y los usuarios), que pueden acceder al archivo
	12K es el peso del archivo
	May 17 11:49, es la fecha y hora en la que creado o modificado el archivo por última vez.
	
También en nuestra terminal podemos movernos entre esas carpetas y listar su contenido, para ello usaremos el comando **cd**,**ls** y **pwd**:

	pwd
	/Users/castrolab04/Desktop/Workshop-PUC/dia1
	cd ..
	en este caso escribimos .. para volver a una carpeta anterior.
	pwd
	/Users/castrolab04/Desktop/Workshop-PUC
	ls
	LICENSE		dia1		dia3
	README.md	dia2		images
	
	y podemos seguir retrocediendo en nuestras carpetas
	cd ..
	pwd
	/Users/castrolab04/Desktop
	
	y para entrar a una carpeta, solo le damos el nombre de la carpeta (o ruta), al comando cd
	cd Workshop-PUC/dia1
	
## Manejo de archivos de texto

Un archivo de texto se define como un archivo que contiene caracteres sin algún patron en específico, existen varias formas de crear un archivo una de ellas es **redireccionando la salida de los comandos**, esto parece ser complejo pero no lo es tanto. Recuerdan nuestras variables: variable1, variable2, variable3 y variable4.

	echo $variable1, $variable2, $variable3, $variable4
	Despacito, Quiero respirar tu cuello despacito, Deja que te diga cosas al oído, Para que te acuerdes si no estás conmigo
	
Podemos redireccionar el resultado (o salida en la jerga programática), para que en vez de ser imprimido en la pantalla, sea guardado en un archivo, para ello agregamos ">" seguido de algún nombre para nuestro archivo.

	pwd
	/Users/castrolab04/Desktop/Workshop-PUC/dia1
	echo $variable1, $variable2, $variable3, $variable4 > despacito.txt
	
	ls
	Dia1_introduccion.md	despacito.txt
	
	si queremos agregar lineas adicionales al archivo, simplemente agregamos >>
	echo "Dime dime dime si tu quieres andar conmigo" >> despacito.txt
	
	si el archivo no esta creado, lo creará
	y si existe, las lineas se agregaran al final del archivo
	
Así tenemos nuestro archivo creado y ya no tenemos que escribir las variables otra vez en caso que cerremos la terminal o apaguemos el computador. ¿Ahora que pasa si queremos mover el archivo de ubicación? Para esto existe el comando **mv**

	imaginemos que queremos mover el archivo despacito.txt, a la carpeta anterior de la que estamos.
	La sintaxis es: [comando] [archivo a mover] [ruta de destino]
	
	mv despacito.txt ../
	
	y si queremos recuperar el archivo, hacemos el movimiento inverso
	mv ../despacito.txt .
	
	aquí el punto significa "ruta actual", así es un tanto fácil recordar:
	.. = ruta anterior
	.  = ruta actual
	
	así el comando se interpretaría como: mover ruta_anterior/despacito.txt hacia_ruta_actual
	
Otra parte muy util de la terminal es la búsqueda de palabras en un archivo, de esta forma evitas abrir un archivo que pueda tener muchos GB de información. El comando encargado de esto es **grep**

	grep "quieres" despacito.txt
	Dime dime dime si tu quieres andar conmigo

	el comando grep entrega la línea entera donde se encuentra el patron de búsqueda.

Muy bien!, pero ha llegado la hora de decir adios a nuestro archivo. Para ello usaremos el comando **rm** (ten cuidado con este comando, ya que todo lo que toca lo desaparece).

	rm despacito.txt
	(el comando rm no retorna mensajes a menos que sea alguno relacionado con no poder eliminar el archivo).
	ls
	Dia1_introduccion.md

Puede que resulten ser muchos comandos en un principio, pero solo la práctica hará que puedas dominarlos, y un dato curioso, **existen mas de 200 comandos** disponibles en tu computadora, y los usaremos **TODOS**.................................................es una broma, solo usaremos algunos como los ya vistos pero de forma mas integrativa.

Nota: Eventualmente se nos olvidarán como funcionan algunos comandos, pero cada uno tiene un manual, **man** es el comando que convoca a los manuales de los comandos:

	man ls
		S(1)                     BSD General Commands Manual                    LS(1)
	
	NAME
	     ls -- list directory contents
	
	SYNOPSIS
	     ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]
	
	DESCRIPTION
	     For each operand that names a file of a type other than directory, ls
	     displays its name as well as any requested, associated information.  For
	     each operand that names a file of type directory, ls displays the names
	     of files contained within that directory, as well as any requested, asso-
	     ciated information.
	
	     If no operands are given, the contents of the current directory are dis-
	     played.  If more than one operand is given, non-directory operands are
	     displayed first; directory and non-directory operands are sorted sepa-
	     rately and in lexicographical order.
	     
Presiona "q" para salir

¿Conoces el archivo fasta?, es el formato por excelencia para guardar secuencias de ADN, ARN o Proteínas, tiene el siguiente formato:

	>header o identificador, suele tener información concisa acerca de la secuencia
	GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC
	GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC
	
creemos nuestro propio fasta!

	primero crearemos el archivo 1.fasta solo con el header del archivo
	echo ">mi_secuencia" > 1.fasta
	ahora agregaremos una secuencia al final del archivo
	echo "GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT" >> 1.fasta
	y podemos agregar otra secuencia al final.
	echo "GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA" >> 1.fasta
	y otra
	echo "GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC" >> 1.fasta
	
ahora veamos nuestro archivo por la terminal!, usaremos el comando **cat**:

	cat 1.fasta
	>mi_secuencia
	GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC
	
	Felicidades!, hemos hecho un archivo fasta
	
	repitamos el proceso pero el fasta deberá llamarse test.fasta
	
	echo ">mi_secuencia_2" > test.fasta
	echo "PKCKPAEECKELAPCKAELKCKLEAPLKECKLAKCLAPEKCLPP" >> test.fasta
	
	Listo!
	
Si rápidamente queremos buscar algún patron en el fasta por ejemplo una pequeña secuencia "CGAT" podemos usar el comando grep:

	grep -n "CGAT" 1.fasta
	2:GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	
	su sintaxis humana sería: [comando + opciones] [patrón] [donde buscar patrón]

Donde:

* grep es el comando para buscar patrones
* -n es un parámetro de grep para indicar en que número de linea encuentra el match
* "CGAT" es el patron para buscar
* 1.fasta es el archivo donde se buscara el patrón

## Wildcard o Expresiones regulares
Las wildcard o expresiones regulares, son símbolos que representan patrones, nos ayuda a aumentar nuestro umbral de match cuando queremos buscar algo. Por ejemplo, ¿que pasa si dentro de una carpeta con 100 archivos, solo queremos mostrar aquellos cuyo nombre empieza con algún número? esto se resolvería con 2 wildcard:
 
 * [0-9] esta wildcard significa "todos los números enteros entre 0 y 9", también puede escribirse así: [0123456789]
 * \* esta wildcard significa "todo"

Combinadas serian "[0-9]*" y se interpretaría como, "todo lo que empieza entre 0 y 9, seguido de cualquier cosa". y Listo, tenemos nuestra wildcard, ahora solo tenemos que escoger el comando de acuerdo a nuestras necesidades.

Como queremos "mostrar" archivos, el comando correspondería a **ls** pero aplicando la wildcard

	ls [0-9]*
	1.fasta
	
	ahora solo nos muestra los archivos de acuerdo a la wildcard.
	también, si no recuerdas el nombre de un archivo pero tienes alguna idea, puedes usar las wildcard para encontrarlo
	
	ls t*
	test.fasta
	
	también podemos duplicar un archivo con el comando cp
	cp 1.fasta 2.fasta
	
	sintaxis: [copiar] [lo que quiero copiar] [nombre destino]
	
Recuerdas el comando **cat**? se usa para mostrar el contenido de un archivo en la terminal, y podemos usarlo también para combinar 2 archivos fasta y obtener nuestro primer multi-fasta.

	cat 1.fasta 2.fasta	> 3.fasta
	cat 3.fasta
	>mi_secuencia
	GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC
	>mi_secuencia
	GCAAGCGGCTAGCTAGCTACTACCAGCGATCACGAGCATCGATCGATGCT
	GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	GCGCGCGCGCGCGCGCGCGCGGGGGGGGGGGGGGGCCCCCCCCCCCCCCC
	
Podemos usar las expresiones regulares con el comando **grep** para buscar algún patron (una caja TATA tal vez?), en varios archivos a la vez:

	grep -n "TATA" *.fasta
	1.fasta:3:GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	2.fasta:3:GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	3.fasta:3:GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	3.fasta:7:GTCGTCGAGTCGTAGCTATATTGCGAGCAGAAATATATATTATATATATA
	
	esto nos muestra en cada archivo, en cada numero de línea el match que buscamos. 
	Al buscar archivos con "*" estamos diciendo al comando grep que busque en todo lo que termine con .fasta

Quizás puede servirnos solo contar el numero de match de nuestra secuencia, aquí el comando a utilizar es **wc** (word count):

	grep -n "TATA" *.fasta |wc -l
	4

Usar `|` está dentro de la categoría de redireccionar al igual que `>`. `|` permite usar la salida del primer comando como entrada para el siguiente, en este caso el resultado anterior es tomado por **wc** que cuenta los caracteres y con el parámetro `-l` solo las líneas.
	
	
## Crea tu propio script
Un script es un pequeño archivo con comandos que lee la terminal y las ejecuta en orden desde arriba hacia abajo. Es muy parecido a una receta de cocina. Es más, cocinemos un archivo fastq!

fastq es un archivo de text que tiene un formato en particular similar al fasta (también guarda secuencias), con la diferencia que un fastq también guarda calidades de la secuencia y tiene el siguiente formato:

	@SEQ_ID
	GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
	+
	!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65
	
* La primera linea es el header del fastq y siempre empieza con un @
* La segunda linea es la secuencia, igual que un archivo fasta
* la tercera linea es un "+" para (opcionalmente), poner descripciones de la secuencia
* La ultima linea corresponde a las calidades de cada nucleótido, cada símbolo representa un número y por ende una calidad (usado por ejemplo cuando se manda a secuenciar un organismo, las secuencias llegan en este formato). Para ver que número equivale cada símbolo sigue [este enlace](http://ascii.cl)

Aquí les presentamos un comando para editar (o crear), un archivo: **vi**.

	vi miscript.sh
	(.sh es solo una extensión genérica para indicar que adentro hay (o habrá), código shell (sh).

Se nos abrirá una terminal con nada de contenido y en negro (o blanco, dependiendo de tu terminal), si el archivo miscript.bash existe, entonces se abrirá y podremos modificarlo, de lo contrario se creará.

Para **insertar** texto debemos apretar la letra **i**, con ello todo lo que tecleemos estará en el archivo, y como hemos aprendido un par de comandos, haremos nuestra receta de cocina escribiendo:

	echo "@mi_primer_fastq"
	echo "ATGTTGCAACGATTGGTCGTTGCATTATGCCTGCTTGGGT"
	echo "+"
	echo "CCCCCCC65++)(%%%%).1!''*((((>>>>>()()()>"

Para guardar, presionamos **Escape**, para salir del modo **insertar**, y escribimos "**:wq**" y presionamos Enter.
 
* ":" es para indicar que queremos una acción especial de **vi**
* w es para indicar a **vi** que guarde los cambios.
* q es para indicar que saldremos del editor

Todo esto debiera verse así:
 ![](../images/vimiscript.png)
 
 Y ahora ejecutamos nuestro script usando el comando **bash**: 
 
 	bash miscript.sh
 	@mi_primer_fastq
	ATGTTGCAACGATTGGTCGTTGCATTATGCCTGCTTGGGT
	+
	CCCCCCC65++)(%%%%).1!''*((((>>>>>()()()>
	
	podemos redireccionar la salida de un script
	bash miscript.sh > miprimer.fastq
	
Cuando se trabaja en bioinformática, es normal que los archivos fasta o fastq sean muy grandes, con muchas secuencias y que ocupen muchos Gigas de espacio. Por eso no es descabellado pensar que podemos reducir su tamaño (y no nos referimos a botar a la basura la mitad de las secuencias), nos referimos a **comprimir** y usaremos el comando **gzip**:

	en nuestro tendríamos que escribir:
	gzip 1.fasta
	gzip 2.fasta
	gzip 3.fasta
	gzip test.fasta
	gzip miprimer.fastq
	
Esto se volvería imposible de hacer si tenemos 1000 fastas, por eso es mejor usar un **ciclo for**. La estructura de un **for** es:

	for variable in $(comando)
	do
		comandos, scripts o recetas de cocina
	done
	
en nuestro caso sería

	for mi_archivo in $(ls *.fast[aq])
	do
		gzip $mi_archivo
	done
	
	ls *.fast[aq]
	1.fasta.gz	2.fasta.gz	3.fasta.gz	test.fasta.gz	miprimer.fastq.gz

En este caso la sintaxis del ciclo **for** la acompañamos de una expresión regular donde apuntamos a "todo (`*`) lo que termine con `.fast` y además el último carácter debe terminar en `a` o `q`". El resultado de esta expresión regular es tomado por **ls** y luego por el ciclo **for**, agregandose a una variable (la misma variable se renueva con otro valor en cada "vuelta").

## Aplicando todo
Primero descarga y descomprime este pequeño set de secuencias [aquí](https://github.com/microgenomics/Workshop-PUC/blob/master/dia1/problem1.zip). Tenemos el siguiente caso: Han llegado secuencias NGS a nuestro laboratorio en formato fastq, y nuestro jefe quiere rápidamente unas estadísticas iniciales, como el número de secuencias, cuanto pesan los archivos y mostrar estos resultados para cada muestra en un archivo llamado reporte.txt.

Primero entramos en la carpeta descomprimida

	cd problema1

podemos empezar escribiendo el reporte con un título y guardarlo mientras en el archivo requerido.

	echo "Estadísticas iniciales" > reporte.txt
	
listamos el directorio para saber cuantos archivos hay
	
	ls
	muestra1.fastq	muestra3.fastq	muestra5.fastq	muestra7.fastq
	muestra2.fastq	muestra4.fastq	muestra6.fastq
	
aquí podemos de inmediato responder la pregunta de cuanto pesan los 
archivos tan solo agregando el parámetro antes usado -lh

	ls -lh
	-rw-r--r--  1 castrolab04  staff   3.4K May 17 18:31 muestra1.fastq
	-rw-r--r--  1 castrolab04  staff   4.6K May 17 18:31 muestra2.fastq
	-rw-r--r--  1 castrolab04  staff   8.9K May 17 18:32 muestra3.fastq
	-rw-r--r--  1 castrolab04  staff   4.7K May 17 18:32 muestra4.fastq
	-rw-r--r--  1 castrolab04  staff   6.8K May 17 18:32 muestra5.fastq
	-rw-r--r--  1 castrolab04  staff   6.4K May 17 18:33 muestra6.fastq
	-rw-r--r--  1 castrolab04  staff   5.0K May 17 18:33 muestra7.fastq

y esto podemos guardarlo mientras en nuestro archivo reporte .txt

	echo "Peso de los archivos" >> reporte.txt
	ls -lh *.fastq >> reporte.txt
	
para resolver la petición de saber cuantas secuencias existen, recuerden que existe el comando **wc -l**

	echo "Cantidad de secuencias" >> reporte.txt
	wc -l muestra1.fastq
	40 muestra1.fastq
	
	en este caso son 40 líneas en el fastq, pero recordemos que en realidad un fastq contiene 1 secuencia cada 4 líneas.
	Así que para obtener el número real, debemos dividir el número de wc en 4. 
	La forma mas rápida es con un pequeño truco en "awk"
	
	wc -l muestra1.fastq |awk '{print $1/4, $2}'
	40
	
ahora veamos que significa este nuevo truco (ya un poco más avanzado), llamado awk: todo código awk puesto en la terminal va encerrado entre comillas simples y en bloques de llaves `'{}'`. `print` es una función de awk para imprimir en pantalla la variable que este al lado de la función, en este caso `$1/4`, que a su vez `$1` significa **columna 1**, y como sabemos que la primera columna es el número que entrega **wc -l** lo dividimos por 4 (`/4`), por ultimo `, $2` significa que habrá un espacio e imprimirá la columna 2 (el nombre de la muestra), resultando así en `'{$1/4, $2}'`.

Ahora bien, resultaría un poco tedioso hacer este comando 7 veces (incluso hay proyectos con mas de 700 muestras), por lo que haremos uso del ciclo para calcular el número de secuencias.

	Recuerden que para acceder al valor de una variable se antepone "$"
	for mifastq in $(ls *.fastq)
	do
		wc -l $mifastq |awk '{print $1/4, $2}'
	done
	
	10 muestra1.fastq
	12 muestra2.fastq
	20 muestra3.fastq
	11 muestra4.fastq
	15 muestra5.fastq
	15 muestra6.fastq
	10 muestra7.fastq

y guardamos este resultado en reporte.txt

	for mifastq in $(ls *.fastq)
	do
		wc -l $mifastq |awk '{print $1/4, $2}'
	done >> reporte.txt
	
Y listo! podemos ver el resultado mostrando el reporte con el comando **cat**
	
	cat reporte.txt
	Estadísticas iniciales
	Peso de los archivos
	-rw-r--r--  1 castrolab04  staff   3.5K May 17 18:47 muestra1.fastq
	-rw-r--r--  1 castrolab04  staff   4.6K May 17 18:31 muestra2.fastq
	-rw-r--r--  1 castrolab04  staff   8.9K May 17 18:32 muestra3.fastq
	-rw-r--r--  1 castrolab04  staff   4.7K May 17 18:32 muestra4.fastq
	-rw-r--r--  1 castrolab04  staff   6.8K May 17 18:32 muestra5.fastq
	-rw-r--r--  1 castrolab04  staff   6.4K May 17 18:33 muestra6.fastq
	-rw-r--r--  1 castrolab04  staff   5.0K May 17 18:33 muestra7.fastq
	Cantidad de secuencias
	10 muestra1.fastq
	12 muestra2.fastq
	20 muestra3.fastq
	11 muestra4.fastq
	15 muestra5.fastq
	15 muestra6.fastq
	10 muestra7.fastq
		
Y listo!, ya podemos enviar el reporte a nuestro jefe, por mientras, seguiremos con el tutorial pero ahora desde una perspectiva desde el código de R. No olviden salir de la carpeta para continuar el tutorial
	
	cd ..

## R: ¿Qué es?
R es un lenguaje de programación para cálculos estadísticos y gráficos  basado en el lenguaje S creado en los laboratorios Bell (Lucent Technologies). Muy popular en la ciencia debido a sus gráficos de alta calidad y versatilidad al momento de mostrar lo que se tiene en mente.

## Instalación

Para **MacOS**:

	wget https://cloud.r-project.org/bin/macosx/R-3.4.0.pkg
	luego doble-click y seguimos los pasos de la instalación.
	
Para **Linux**:

	sudo apt-get update
	sudo apt-get install r-base
	sudo apt-get install r-base-dev
	
Bingo!, ya tenemos R instalado veamos que tal es, abramos una terminal y escribimos `R` y presionamos enter

![](../images/Rconsole.png)

La verdad es bastante poco amigable el código en si. ya tiene sus complicaciones manejar una shell como para manejar una shell dentro de otra shell. Es por esto que les presentamos **RStudio**