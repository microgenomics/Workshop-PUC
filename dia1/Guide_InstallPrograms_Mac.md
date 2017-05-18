![banner](https://github.com/microgenomics/Workshop-PUC/blob/master/images/logocbibhorizontal.png?raw=true)

## Microbial Genomics Lab

[Katterinne Mendez](https://github.com/Katterinne) - [Sandro Valenzuela-Diaz](https://github.com/Sanrrone) - [Eduardo Castro-Nallar](https://github.com/ecastron)

---

> Workshop-PUC

# Instalación de Requisitos para Mac OS X

**¡Bienvenidos!** Si tienes una computadora **Mac** y quieres hacer **Bioinformática**, estás en el tutorial indicado. A continuación los pasos a seguir para acondicionar tu Mac con las configuraciónes y programas básicos para correr programas bioinformáticos y poder analizar tus datos.

Esta guía está orientada a la instalación de requisitos necesarios para completar el trabajo práctico del **_workshop_** de "**Bioinformática: secuenciación masiva y genómica**".

---

### Instala Xcode

Primero debes revisar si `Xcode` está o no instalado en tu computadora. Abre `Spotlight Search` haciendo clic en el ícono de la lupa en la parte superior derecha de tu pantalla o usa el acceso rápido del teclado, presiona `command`->`space`. Escribe "xcode", si aparece (como se ve en la imágen) lo tienes, de lo contrario debes instalarlo.

![Xcode_check](https://github.com/microgenomics/Workshop-PUC/blob/master/images/Xcode_check.png?raw=true)

Para instalar Xcode en tu computadora Mac, dirígete a `Applications` y abre `App Store`, en el buscador escribe `Xcode` -> descarga e instala la aplicación.

![Xcode_AppStore](https://github.com/microgenomics/Workshop-PUC/blob/master/images/Xcode_AppStore.png?raw=true)

---

### Instala Homebrew

[Homebrew](https://brew.sh/index_es.html) es un gestor de paquetes para Mac, una herramienta muy útil que te facilitará la vida, ya que, te permite instalar programas y softwares de forma fácil y eficiente. Si lo que estás buscando se encuentra en la base de datos de homebrew, no tienes que preocuparte, homebrew hará el trabajo por ti.

Para **instalar Homebrew**, dirígete a `Applications` y abre la `Terminal` <img src="https://github.com/microgenomics/Workshop-PUC/blob/master/images/terminal.png?raw=true" alt="alt text" width="40" height="50">

Copia la siguiente línea en la `Terminal` y presiona `enter`

	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	
Espera pacientemente... y listo!... cierra la `Terminal`

---

### Lenguajes de Programación: Perl, Python y Java

La mayoría de los programas bioinformáticos están escritos en los lenguajes de programación `perl`, `python` y `java`. Necesitas tenerlos en tu computadora para que ésta pueda ejecutarlos.

Primero debes *checkear* si `perl`, `python` y `java` están operativos en tu computadora.

1.- Para *checkear* `perl`:

	# Abre la terminal y escribe:
	$ perl --version
	This is perl 5, version 24, subversion 1 (v5.24.1) built for darwin-thread-multi-2level 	# Felicidades! tienes perl!
	-bash: perl: command not found	# Debes instalar perl!

2.- Para *checkear* `python`:

	# Abre la terminal y escribe:
	$ python --version
	Python 2.7.10						# Felicidades! tienes python!
	-bash: python: command not found	# Debes instalar python!

3.- Para *checkear* `java`:

	$ java -version
	java version "1.8.0_131"		# Felicidades! tienes java!
	-bash: java: command not found	# Debes instalar java!

¿Cómo te fue?... sigue los pasos a continuación para instalar según corresponda.

#### Instala Perl

En la `Terminal` copia la siguiente línea y presiona `enter`

	curl -L http://xrl.us/installperlosx | bash
	
Espera pacientemente... y listo!... cierra la `Terminal`

#### Instala Python

En este caso utilizaremos `Homebrew`, verás lo sencillo que es. Abre la `Terminal` y escribe:

	$ brew install python

Espera pacientemente... y listo!... cierra la `Terminal`

##### BIOPYTHON

Biopython es una serie de programas escritos en lenguaje de programación python con el objetivo de analizar y/o procesar datos biológicos.

Primero debemos instalar las dependencias (requisitos) de `biopython`. Abre la `Terminal` y escribe:

	$ pip install numpy
	# pip es un gestionador de instalación de paquetes escritos en python
	# NumPy es un paquete escrito en python
	$ pip install scipy
	$ pip install pandas
	# Listo!... cierra la Terminal

Para instalar `biopython` abre la `Terminal` y escribe:

	$ sudo easy_install -f http://biopython.org/DIST/ biopython
	Password:		# La Terminal te pedirá una contraseña - ingresa tu contraseña del computador
	# El comando sudo es para obtener permisos de administrador

Espera pacientemente... y listo!... cierra la `Terminal`

#### Instala Java

Dirígete a la página de descarga de `java` [aquí](https://www.java.com/es/download/). Haz clic en la opción `Descarga gratuita de Java` y sigue las instrucciones.

![java](https://github.com/microgenomics/Workshop-PUC/blob/master/images/java.png?raw=true)

---

### Personaliza tu `Terminal`

En las computadoras Mac, por defecto la `Terminal` se ve en blanco y negro, así:

![terminal_nocolor](https://github.com/microgenomics/Workshop-PUC/blob/master/images/terminal_nocolor.png?raw=true)

El hecho de tener colores en la `Terminal` no se trata de estética solamente, sino que te permite diferenciar distintos tipos de archivos. ¿Quieres colores en tu `Terminal`?... sigue los pasos a continuación:

	# Abre la Terminal...
	$ cd		# para salir de todas las carpetas
	$ vi .bash_profile
	# Presiona la tecla 'i' para poder editar y copia y pega lo siguiente:
	
	export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
	export CLICOLOR=1
	export LSCOLORS=ExFxBxDxCxegedabagacad
	alias ls='ls -GFh'
	
	# Presiona la tecla 'esc' para salir del editor y escribe:
	$ :wq
	# Los cambios son guardados y vuelves a la Terminal automáticamente. Ahora escribe:
	$ source .bash_profile

Listo!... cierra la `Terminal` y luego abre la `Terminal` nuevamente.

![terminal_color](https://github.com/microgenomics/Workshop-PUC/blob/master/images/terminal_color.png?raw=true)

Puedes personalizar otras características visuales de tu `Terminal` en la opción `Preferences...` de la barra de herramientas de la `Terminal` en la parte superior de tu pantalla.

---

### Instalación de Programas Para el Trabajo Práctico del Workshop

#### Instala FastQC

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) es una herramienta con interfáz gráfica, capaz de calcular varias estadísticas y evaluar la calidad de las secuencias contenidas en los archivos FASTQ que se le entrega (*input*) (**_Quality Control_**).

Para instalar `FastQC` dirígete a la página de descarga [aquí](https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc) y selecciona el primer link disponible: `FastQC v0.11.5 (Mac DMG image)`, para descargar el archivo DMG. Después sigue las instrucciones y listo!

#### Instala Prinseq-lite

[PRINSEQ](http://prinseq.sourceforge.net) es un programa útil para realizar el control de calidad (**QC**) y pre-procesamiento de tu **_raw data_** (*reads* secuenciados).

Para instalar `Prinseq-lite` descarga el archivo `prinseq-lite-0.20.4.tar.gz` [**aquí**](https://github.com/microgenomics/Workshop-PUC/raw/master/dia1/prinseq-lite-0.20.4.tar). Mueve el archivo a una carpeta adecuada y sigue las instrucciones a continuación:

	# Te recomiendo crear una carpeta llamada "programs" para guardar e instalar programas
	$ cd
	$ mkdir programs
	$ cd programs/
	$ mv ../Downloads/prinseq-lite-0.20.4.tar.gz .
	$ tar -xzvf prinseq-lite-0.20.4.tar.gz
	$ cd prinseq-lite-0.20.4/
	$ chmod +x prinseq-lite.pl
	$ sudo cp prinseq-lite.pl /usr/bin/
	$ cd
	$ prinseq-lite.pl -h	# Listo!

#### Instala SPAdes

[SPAdes](http://bioinf.spbau.ru/spades) es un programa útil para ensamblar genomas *de novo*. Para instalar `SPAdes` sigue los pasos a continuación:

	$ curl http://cab.spbu.ru/files/release3.10.1/SPAdes-3.10.1-Darwin.tar.gz -o SPAdes-3.10.1-Darwin.tar.gz
	$ tar -zxf SPAdes-3.10.1-Darwin.tar.gz
	$ cd SPAdes-3.10.1-Darwin/bin/
	$ pwd
	/path/to/programs/SPAdes-3.10.1-Darwin/bin
	$ cd
	$ vi .bash_profile
	# Presiona la tecla 'i' para poder editar
	# Baja con usando las teclas 'flechas' al final del archivo presiona la tecla 'enter' y escribe:
	
	export PATH="$PATH:/path/to/programs/SPAdes-3.10.1-Darwin/bin"
	
	# Presiona la tecla 'enter' y luego la tecla 'esc' para salir del editor y escribe:
	$ :wq
	# Los cambios son guardados y vuelves a la Terminal automáticamente. Ahora escribe:
	$ source .bash_profile
	$ spades.py -h 		# Listo!

#### Instala Bowtie2

[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) es una herramienta útil y eficiente para alinear *reads* contra largas secuencias de referencia. Para instalar `bowtie2` sigue las siguientes instrucciones:

	$ brew install bowtie2
	# Espera pacientemente...
	$ bowtie2 -h		# Listo!

#### Instala SAMtools

[SAMTools](http://samtools.sourceforge.net) es un conjunto de múltiples herramientas que nos permiten manipular y analizar alineamientos en formato SAM o BAM. Para instalar `samtools` escribe en la `Terminal` lo siguiente:

	$ brew install samtools
	# Espera pacientemente...
	$ samtools --help	# Listo!

#### Instala Bedtools

[Bedtools](http://bedtools.readthedocs.io/en/latest/) es un conjunto de múltiples herramientas para el cálculo de varias estadísticas sobre una o varias secuencias de ADN. Para instalar `bedtools` sigue los pasos a continuación:

	$ brew install bedtools
	# Espera pacientemente...
	$ bedtools -h			# Listo!

#### Instala Bcftools

[Bcftools](https://samtools.github.io/bcftools/bcftools.html) es un conjunto de múltiples herramientas útiles para manipular archivos *Variant Call Format* (VCF). Para instalar `bcftools` escribe en la `Terminal` lo siguiente:

	$ brew install bcftools
	# Espera pacientemente...
	$ bcftools -h			# Listo!

#### Instala Seqtk

[Seqtk](https://github.com/lh3/seqtk) es un set de herramientas útiles para manipular y procesar secuencias en formato FASTA o FASTQ. Para instalar `seqtk` sigue los pasos a continuación:

	$ brew install seqtk
	# Espera pacientemente...
	$ seqtk		# Listo!

#### Instala Prokka

[Prokka](http://www.vicbioinformatics.com/software.prokka.shtml) es un software útil y eficiente para la anotación de genomas procariontes. Para instalar `prokka` sigue las siguientes instrucciones:

	$ cpan install Bio::Perl		# espera pacientemente... atento, la Terminal pedirá tu contraseña...
	$ cpan install XML::Simple		# espera pacientemente...
	$ brew install prokka --HEAD
	# Espera pacientemente...
	$ prokka -h		# Listo!

#### Instala Artemis

[Artemis](http://www.sanger.ac.uk/science/tools/artemis) es una herramienta con interfáz gráfica visualizar y analizar secuencias. Para instalar `Artemis` descargar el archivo DMG **[aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia1/artemis_act_dev.dmg.zip)**. Doble clic en el archivo `.dmg` y arrastra los íconos de `Artemis`, `ACT` y `DNAPlotter` hasta la carpeta `Applications`. Listo!

![Artemis_app](https://github.com/microgenomics/Workshop-PUC/blob/master/images/Artemis_app.png?raw=true)

#### Instala Stacks

[Stacks](http://catchenlab.life.illinois.edu/stacks/) es una pipeline para procesar reads obtenidos mediante técnicas de representación reducida del genoma como RAD-seq (*Restriction-site Associated DNA sequencing*). Para instalar `Stacks` sigue las siguientes instrucciones:

	$ brew install stacks		# espera pacientemente...
	$ cpan install Bundle::DBI

#### Instalar MySQL

[MySQL](https://dev.mysql.com) es un motor de base de datos de libre acceso. Para instalar `MySQL` descarga el archivo DMG de MySQL desde la [página](https://dev.mysql.com/downloads/mysql/) o **[aquí](https://dl.dropboxusercontent.com/u/73361402/mysql-5.7.18-macos10.12-x86_64.dmg.zip)**.

Haz doble clic en el archivo DMG y sigue las instrucciones, pon atención en el mensaje que aparecerá durante la instalación de MySQL, como el que se muestra en la siguiente imágen, y toma nota de la contraseña que aparece, la necesitarás mas adelante.

![mysql_installer](https://github.com/microgenomics/Workshop-PUC/blob/master/images/mysql_installer.png?raw=true)

Ahora dirígete a `System Preferences` -> `MySQL` y haz clic en `Start MySQL Server`, deberías ver algo así:

![mysql_start](https://github.com/microgenomics/Workshop-PUC/blob/master/images/mysql.png?raw=true)

Ahora abre la terminal y escribe...

	$ mysql -u root -p
	# Aparecerá un mensaje pidiendo una contraseña, la misma que el instalador de MySQL te dió en el paso anterior.
	$ Enter password: XoryZ!lea3/y
	# Verás algo así...
	
	Welcome to the MySQL monitor.  Commands end with ; or \g.
	Your MySQL connection id is 194
	Server version: 5.7.18 MySQL Community Server (GPL)
	
	Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.
	
	Oracle is a registered trademark of Oracle Corporation and/or its
	affiliates. Other names may be trademarks of their respective owners.

	Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
	
	mysql> 
	
	# La contraseña que nos entrego el instalador de MySQL es temporal, por lo que debemos cambiarla...
	# Aún en mysql escribe la siguiente línea de comando para cambiar la contraseña por cualquier otra de tu elección...
	$ mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyPassword';
	# Asegúrate de reemplazar MyPassword por tu nueva contraseña
	# Para salir de mysql escribe:
	$ quit;
	
	# Puedes volver a entrar a mysql, esta vez, escribiendo tu nueva contraseña, para asegurar que el cambio fue exitoso!
	# Siempre que quieras entrar a mysql escribe:
	$ mysql -u root -p
	# Y luego escribes tu contraseña (asegurate de no olvidarla!)
	# Para salir de mysql escribe:
	$ mysql> quit;

Excelente! `MySQL` está disponible en tu computadora. Sólo nos hace falta modificar un archivo de configuración, para que `Stacks` pueda acceder a `mysql`:

	$ cd /usr/local/Cellar/stacks/1.46/share/stacks/sql/
	$ mv mysql.cnf.dist mysql.cnf
	$ vi mysql.cnf
	# Se abrirá el archivo mysql, presiona la tecla i para poder editar, verás algo así...
	
	[client]
	user=root
	password=XoryZ!lea3/y
	host=localhost
	port=3306
	local-infile=1
	
	# En 'password=' cambia la antigua contraseña por la nueva contraseña
	$ cd

Listo!


