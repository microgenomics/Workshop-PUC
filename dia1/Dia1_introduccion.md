![banner](../images/logocbibhorizontal.png)
# Introducción a la Terminal y R.
--------
Hola!, bienvenidos al primer práctico de uso de terminal y R, aquí aprenderás los comandos esenciales usados en la terminal (o consola de comandos, o shell), y que son la base en el manejo de cualquier proyecto que tenga bioinformática en él. Así qué... manos a la obra!.

**Recordatorio: Nunca escribas variables, nombres de archivo o de carpetas con ESPACIOS. Los espacios son enemigos naturales de las terminales.**

## ¿Que es una Terminal?

|	<img src="../images/terminal.png" alt="alt text" width="150"> | <img src="../images/terminal2.ico" alt="alt text" width="100">	| <img src="../images/terminal3.jpg" alt="alt text" width="200"> | <img src="../images/terminal4.jpg" alt="alt text" width="200"> |
|:-:|:-:|:-:|:-:|
|Esta es una terminal| esta también es una terminal| Esto es la matrix, se hacen cosas parecidas en bioinformática, así que consideremos esta una terminal también| Esto es un ramsomware, el virus que atacó a Movistar hace unos días, hecho para windows, esto no es una terminal.|

Una terminal es un intérprete de comandos, fundamental en los sistemas operativos para la interacción con el usuario ya que se escriben comandos y acciones en él, esto también es considerado un lenguaje de programación. En este practico solo nos concentraremos en las terminales basadas en Unix (Linux o Mac, los siento Windows esta vez no).

## ¿Qué puedo hacer con la terminal?
Prácticamente todo lo que hace un computador, con una terminal tu ordenas lo que quieres y el computador lo hará, lo difícil es transmitir lo que realmente pensamos a la terminal.

## Primeras ordenes
Cuando se aprende un nuevo lenguaje de programación, lo tradicional es hacer que el computador nos diga "Hola Mundo" en dicho lenguaje de programación. Así que primer paso: Abrir una terminal como esta:
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
la terminal no solo sirve para realizar operaciones como una calculadora o hacer que escriba una canción, también es frecuentemente usado para manipular directorios, el primer paso en el uso de estos, es la creación de una carpeta, para ello el comando a usar se llama **mkdir**:

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
	
también en nuestra terminal podemos movernos entre esas carpetas y listar su contenido, para ello usaremos el comand **cd**,**ls** y **pwd**:

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

¿Conoces el archivo fasta?, es el formato por excelencia para guardar secuencias de ADN, ARN o Proteínas.