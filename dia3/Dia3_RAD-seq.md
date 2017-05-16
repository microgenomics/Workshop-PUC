###### Día 3 - Práctico: procesamiento de datos propios.
# Técnicas de representación reducida del genoma

## STACKS software

> [RADSeq: next-generation population genetics](https://academic.oup.com/bfg/article/9/5-6/416/182576/RADSeq-next-generation-population-genetics#1693374)

##### **[Stacks](http://catchenlab.life.illinois.edu/stacks/)** es una *[pipeline](https://en.wikipedia.org/wiki/Pipeline_(software))* para procesar *reads* obtenidos mediante técnicas de representación reducida del genoma como *Genotype by Sequencing* (GBS) y *Restriction-site Associated DNA sequencing* (RAD-seq), con el fin de llevar acabo estudios de diversidad genética poblacional.

+ Esta pipeline consta de **5 etapas** principales:

1. Los *reads* son *[demultiplexed](https://en.wikipedia.org/wiki/Multiplexing)* y filtrados por calidad (descarte de *reads* de baja calidad), usando el programa `process_radtags`

2. Los datos de cada individuo son agrupados en *loci*, para luego identificar nucleótidos polimórficos usando el programa `pstacks` en el caso de contar con genoma de referencia o `ustacks` para *de novo*

3. Creación del catálogo de *loci* usando el programa `cstacks`

4. *Loci* de cada individuo es comparado contra el catálogo para determinar el estado alélico de cada *locus* en cada individuo, usando el programa `sstacks`

5. Puedes usar el programa `genotypes` para hacer un mapa genético y/o el programa `populations` para análisis estaísticos que darán como resultado varios *outputs* útiles para utilizar en otros programas de genética poblacional

![Stacks_pipeline](https://github.com/microgenomics/Workshop-PUC/blob/master/images/Stacks_pipeline.png?raw=true "scheme")
> (Figure 1) Catchen, J., Hohenlohe, P. A., Bassham, S., Amores, A. and Cresko, W. A. (2013), Stacks: an analysis tool set for population genomics. Mol Ecol, 22: 3124–3140. doi:10.1111/mec.12354

---

### Instalar stacks

#### Mac

	$ brew install stacks
	$ cpan install Bundle::DBI

#### Linux

Descarga Stacks [aquí](http://catchenlab.life.illinois.edu/stacks/)

	$ sudo apt-get install libdbd-mysql-perl
	$ sudo apt-get install libsparsehash-dev
	
	$ tar xfvz stacks-x.xx.tar.gz
	$ cd stacks-x.xx
	$ ./configure
	$ make
	$ make install

---

## Manos a la obra !!

### Archivos de entrada (*input*)

De ahora en adelante, puedes utilizar tus propios datos (los *reads* que recibiste en uno o varios archivos FASTQ directamente del proceso de secuenciación). Recuerda poner especial atención en los parámteros/opciónes disponibles en cada programa paso a paso. Siempre es importante saber qué le ocurre a tus datos al correr cada programa, para ello debes conocer las opciónes disponibles y escoger las mas adecuadas para tu experimento. Puedes conocer los parámetros diponibles de cualquier programa usando la opción `-h` / `--help`, por ejemplo: `$ process_radtags -h`. Por supuesto, obtendrás más detalles y ejemplos si revisas la documentación del programa. Stacks cuenta con un manual detallado que puedes ver [aquí](http://catchenlab.life.illinois.edu/stacks/manual/#intro).
 
¿Aún esperas tus secuencias (*reads*)?... está bien, puedes utilizar los datos ejemplo que procesamos en el presente tutorial, éstos corresponden a los *reads* de un sub-muestreo que tomamos del estudio de [Catchen y cols., 2013](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3712868/?report=classic). BioProject [PRJNA195932](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA195932). En éste estudio se tomaron 590 muestras de la aleta caudal y ambas aletas pectorales de ejemplares de *Gasterosteus aculeatus* (pez espinoso o "*the threespine stickleback fish*" en inglés) en 9 zonas diferentes en las costas de Oregon, USA. Luego se extrajo ADN total de cada muestra y se construyeron las librerías RAD (*restriction site-associated DNA*) de tipo *single-end*, usando la enzima de restricción sbfI. En honor al tiempo, para este tutorial solo utilizaremos 18 muestras, 2 por cada zona.

> Catchen, J., Bassham, S., Wilson, T., Currey, M., O’Brien, C., Yeates, Q., & Cresko, W. A. (2013). The population structure and recent colonization history of Oregon threespine stickleback determined using RAD-seq. Molecular Ecology, 22(11), 2864–2883. http://doi.org/10.1111/mec.12330

+ Puedes descargar los archivos FASTQ [aquí](https://dl.dropboxusercontent.com/u/73361402/PRJNA195932_18subset.zip).

La siguiente tabla muestra algunos datos útiles sobre los archivos FASTQ que acabas de descargar, éstos tienen el mismo nombre que puedes ver en la columna `Sample_Name`, que corresponde al nombre que los autores le dieron a cada muestra. La columna `biome` corresponde al ambiente en dónde se tomaron las muestras, en este caso, océano y agua dulce. La columna `geographic_location` corresponde a la localización geográfica dónde se tomó cada muestra. Éstas son sólo un poco de la información diponible en la base de datos [SRA](https://www.ncbi.nlm.nih.gov/sra) (*Sequence Read Archive*) de [NCBI](https://www.ncbi.nlm.nih.gov) acerca de éste estudio, puedes descargar la tabla completa [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia3/PRJNA195932_SRA_table.xlsx).

|Sample_Name	|biome			|geographic_location 	 						|
|---------------|---------------|-----------------------------------------------|
|cr_1533.05		|Freshwater		|USA: OR, Central Oregon, Crooked River 		|
|cr_1533.17		|Freshwater		|USA: OR, Central Oregon, Crooked River 		|
|cs_1335.17		|Ocean			|USA: OR, Oregon coast, Cushman Slough 			|
|cs_1335.54		|Ocean			|USA: OR, Oregon coast, Cushman Slough 			|
|ms_2067.51		|Ocean			|USA: OR, Oregon coast, Millport Slough 		|
|ms_2067.66		|Ocean			|USA: OR, Oregon coast, Millport Slough 		|
|pcr_1211.11	|Freshwater		|USA: OR, Oregon coast, Pony Creek Reservoir 	|
|pcr_1312.13	|Freshwater		|USA: OR, Oregon coast, Pony Creek Reservoir 	|
|pl_1537.11		|Freshwater		|USA: OR, Central Oregon, Paulina Lake 			|
|pl_1537.27		|Freshwater		|USA: OR, Central Oregon, Paulina Lake 			|
|rb_2240.128	|Freshwater		|USA: OR, Willamette Basin, Riverbend 			|
|rb_2240.158	|Freshwater		|USA: OR, Willamette Basin, Riverbend 			|
|sj_1879.31		|Ocean			|USA: OR, Oregon coast, South Jetty 			|
|sj_1879.34		|Ocean			|USA: OR, Oregon coast, South Jetty 			|
|stl_1274.63	|Freshwater		|USA: OR, Central Oregon, South Twin Lake 		|
|stl_1274.72	|Freshwater		|USA: OR, Central Oregon, South Twin Lake 		|
|wc_1218.07		|Freshwater		|USA: OR, Oregon coast, Winchester Creek 		|
|wc_1221.02		|Freshwater		|USA: OR, Oregon coast, Winchester Creek 		|

---

#### <img src="https://github.com/microgenomics/Workshop-PUC/blob/master/images/terminal.png?raw=true" alt="alt text" width="40" height="50"> Abre la Terminal

En el tutorial, cuando veas el siguiente símbolo, significa que debes escribir en la terminal la línea de comando que aparezca en cada caso:

	$

Mientras que el siguiente símbolo indica un comentario útil para que entiendas la siguiente línea (no es necesario que lo escribas):

	#

---

### Pre-procesamiento de *reads*

El pre-procesamiento de los *reads* de RAD-seq, obtenidos desde el proceso de secuenciación (*raw data*), consta de dos procesos principales. Primero, identificar los *reads* pertenecientes a cada individuo (*demultiplex*) y recuperarlos en archivos FASTQ independientes, para ello se utilizan los *barcodes* o *index*, que son secuencias pequeñas (5 nucleótidos) presentes en los partidores utilizados en la construcción de las librerías de secuenciación. Y segundo, realizar el control de calidad (QC: *quality control*), donde se descartan los *reads* de baja calidad.

Primero, utiliza `-h` para conocer todas las opciónes disponibles en el programa `process_radtags`:

	$ process_radtags -h

... hacer esto también es útil para *checkear* si el programa está disponible en tu computadora.

Ahora, suponiendo que te encuentras en una carpeta en la cual tenemos las carpetas `raw_data/` donde están los archivos FASTQ y `etapa_1/` donde guardarémos los resultados de la Etapa 1. Además del archivo de texto `barcode-sample_list` que indica la secuencia del *barcodes*/*index* y luego el nombre de la muestra correspondiente, así:

	# en éste caso el archivo de texto consta de 2 columnas (barcode<tab>nombre_muestra) y 18 filas o líneas (una por cada muestra).
	CAGGCA		cr_1533-05
	CGTCTA		cr_1533-17
	CGCGTG		cs_1335-17
	GTCATC		cs_1335-54
	CTTATG		ms_2067-51
	GCGACC		ms_2067-66
	TAGTAT		pcr_1211-11
	GGGCGC		pcr_1312-13
	TACACA		pl_1537-11
	TTATGA		pl_1537-27
	GTGTAA		rb_2240-128
	CACCTC		rb_2240-158
	CCATTT		sj_1879-31
	CCGAGG		sj_1879-34
	CCCTAA		stl_1274-63
	CGTGAT		stl_1274-72
	ATCAAA		wc_1218-07
	ACATAC		wc_1221-02

... descarga el archivo `barcode-sample_list` [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia3/barcode-sample_list.zip).

Ahora evalúa y escribe la línea de commando correcta para tus datos, por ejemplo:

Si tienes single-end reads...

	$ process_radtags -p raw_data/ -i fastq -b barcode-sample_list -o etapa_1/ -c -q -r -s 20 -e sbfI
	
Si tienes paired-end reads...

	$ process_radtags --paired -p raw_data/ -i fastq -b barcode-sample_list -o etapa_1/ -c -q -r -s 20 -e sbfI

Si tienes paired-end reads, pero tanto los reads R1 y R2 se encuentran en el mismo archivo FASTQ...

	$ process_radtags --paired -I -p raw_data/ -i fastq -b barcode-sample_list -o etapa_1/ -c -q -r -s 20 -e sbfI

O si llevaste acabo la técnica de ddRAD-seq (*double-digested restriction site-associated DNA*), en este caso, necesitas indicarle al programa ambas enzimas de restricción que utilizaste y dónde se encuentran los *barcodes* dentro de los archivos FASTQ R1 y R2...

	# Opciónes acerca del barcode/index:
    --inline_null:   barcode se encuentra en la secuencia, sólo para single-end read (configuración por defecto).
    --index_null:    barcode se encuentra en el FASTQ header, sólo para single'end reads.
    --inline_inline: barcode se encuentra en la secuencia, para single y paired-end read.
    --index_index:   barcode se encuentra en el FASTQ header, para single-end y paired-end read.
    --inline_index:  barcode se encuentra en la secuencia para single-end reads, se encuentra en FASTQ header para paired-end reads.
    --index_inline:  barcode se encuentra en FASTQ header para single-end reads, se encuentra en la secuencia para paired-end reads.

	$ process_radtags --paired -p raw_data/ -i fastq -b barcode-sample_list -o etapa_1/ -c -q -r -s 20 --inline_inline --renz_1 sbfI --renz_2 nlaIII
	
> Puedes encontrar más información acerca de los parámetros disponibles para el programa `process_radtags` de `Stacks` [aquí](http://catchenlab.life.illinois.edu/stacks/comp/process_radtags.php).

Cuando estés listo presiona `enter`...

Si obtienes un mensaje de `error` asegúrate de leerlo con atención, te dirá qué está mal y sabrás cómo solucionarlo, también puedes consultar el `error` en `google`... y no te preocupes ! puedes correr un experimento *in silico* cuantas veces sea necesario sin gastar más que tu tiempo y la disponibilidad de tu computadora !

##### Resultados (*output*)

De esta primera etapa esperamos obtener tantos archivos FASTQ como individuos o muestras existentes. Es decir, obtendrás un archivo FASTQ por cada muestra llamados `nombre_muestra.fastq` conteniendo los *reads* específicos y que hayan pasado el control de calidad (QC). Por ejemplo:

	# ingresa a la carpeta etapa_1/ y observa el output de process_radtags
	$ cd etapa_1/
	$ ls
	cr_1533-05.fastq   pcr_1211-11.fastq  sj_1879-31.fastq
	cr_1533-17.fastq   pcr_1312-13.fastq  sj_1879-34.fastq
	cs_1335-17.fastq   pl_1537-11.fastq   stl_1274-63.fastq
	cs_1335-54.fastq   pl_1537-27.fastq   stl_1274-72.fastq
	ms_2067-51.fastq   rb_2240-128.fastq  wc_1218-07.fastq
	ms_2067-66.fastq   rb_2240-158.fastq  wc_1221-02.fastq

+ **Nota**: Los datos ejemplo que descargáste anteriormente ([aquí](https://dl.dropboxusercontent.com/u/73361402/PRJNA195932_18subset.zip)) corresponden a los archivos FASTQ que observamos en el recuadro de arriba, ósea al *output* del pre-procesamiento de *reads*. Por lo que si estás utilizando los datos ejemplo, deberás comenzar desde aquí, ya que, Catchen y cols., (2013) primero realizaron el *demultiplexed* de los *reads* para luego subir los datos por cada muestra a la base de datos SRA de NCBI.

Ya teniendo los *reads* pre-procesados, podemos continuar con el ensamble de los *contigs* (que corresponderían a los *loci*) para luego hacer los análisis de diversidad genética.

### ¿ Referencia o *De Novo* ?

Si cuentas con un genoma de referencia continúa con la siguiente sección **"Alineamiento Contra Genoma de Referencia"**, en el caso contrario continúa con la sección sub-siguiente **"_De Novo_"**.

#### Alineamiento Contra Genoma de Referencia

Primero descarga el genoma de referencia de tu organismo en formato FASTA. Dirígete a la página principal de [NCBI](https://www.ncbi.nlm.nih.gov), selecciona "Genome" en las opciónes del buscador, escribe el género y especie de tu organismo y presiona `Search`. Deberías ver algo como la siguiente imágen:

![NCBI Screenshot](https://github.com/microgenomics/Workshop-PUC/blob/master/images/NCBI_Gaculeatus_Genome.png?raw=true "")

Haz clic en "_Download sequences in fasta format for **genome**_" para descargar el genoma. Si estás utilizando los datos ejemplo, puedes descargar el genoma de *Gasterosteus aculeatus* [aquí](https://dl.dropboxusercontent.com/u/73361402/GCA_000180675.1_ASM18067v1_genomic.fna.gz).

El siguiente paso es mapear los *reads* en contra del genoma de referencia, para ello vamos a utilizar la herramienta bioinformática **[Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)**. Recuerda que debes tener bowtie2 instalado y operativo en tu computador... más detalles en el [tutorial del día 1]() o en el [manual](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml) de la herramienta.

##### Vamos a realizar el alineamiento !!

Antes de correr el mapeo, debemos indexar el genoma para que Bowtie2 pueda usarlo como referencia, usando el programa `bowtie2-build` de Bowtie2:

	# Recordemos que tenemos, hasta ahora, en nuestra actual carpeta de trabajo
	$ ls
	raw_data/
	etapa_1/
	GCA_000180675.1_ASM18067v1_genomic.fna
	# Crea una carpeta para guardar e indexar el genoma de referencia
	$ mkdir reference/
	$ mv GCA_000180675.1_ASM18067v1_genomic.fna reference/
	# Entra a reference/ y usa bowtie2-build para indexar el genoma
	$ bowtie2-build -h  # recuerda darle un vistazo a los parámetros disponibles
	$ bowtie2-build GCA_000180675.1_ASM18067v1_genomic.fna Gaculeatus_reference --threads 4
	
Después de escribir la línea de comando y presionar `enter` el programa `bowtie2-build` comenzará a correr y verás algo como la siguiente imágen:

![bowtie2-build](https://github.com/microgenomics/Workshop-PUC/blob/master/images/run_bowtie2-build.png?raw=true "")

	# Cuando bowtie2-build termine, como output deberías obtener varios archivos con extensión .bt2
	$ ls
	GCA_000180675.1_ASM18067v1_genomic.fna
	Gaculeatus_reference.1.bt2
	Gaculeatus_reference.2.bt2
	Gaculeatus_reference.3.bt2
	Gaculeatus_reference.4.bt2
	Gaculeatus_reference.rev.1.bt2
	Gaculeatus_reference.rev.2.bt2
	
Ahora que ya tenemos indexado el genoma de referencia, podemos correr el alineamiento de los *reads* contra la referencia usando `bowtie2`.

Como las muestras provienen de individuos diferentes, debemos realizar alineamientos independientes, para los datos ejemplo serían 18 alineamientos en total... por supuesto, no tienes que permanecer frente a la pantalla esperando a que un alineamiento termine para lazar el siguiente!... puedes preparar un pequeño ciclo, así:

1.- Crea una lista con los nombres de tus muestras (*sample_names*)... los mismos que se encuentran en la columna 2 del archivo `barcode-sample_list`, así:

	# Sal de la carpeta reference/ y crea una carpeta para guardar los resultados del alineamiento
	$ cd ../
	$ mkdir mapp/
	$ cd mapp/
	# Crea la lista con los nombres de las muestras usando el archivo barcode-sample_list
	$ awk '{print $2}' ../raw_data/barcode-sample_list > samples_list
	# Dale un vistazo al nuevo archivo de texto
	$ cat samples_list
	cr_1533-05
	cr_1533-17
	cs_1335-17
	cs_1335-54
	ms_2067-51
	ms_2067-66
	pcr_1211-11
	pcr_1312-13
	pl_1537-11
	pl_1537-27
	rb_2240-128
	rb_2240-158
	sj_1879-31
	sj_1879-34
	stl_1274-63
	stl_1274-72
	wc_1218-07
	wc_1221-02
	# Excelente! como son 18 muestras, el archivo samples_list debiese tener 18 líneas
	$ wc -l samples_list 
      18 samples_list
      
2.- Revisa las opciónes disponibles en el programa `bowtie2` y define los parámetros a utilizar. Recuerda que puedes obtener ésta información escribiendo `$ bowtie2 -h` en la terminal o [aquí](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#command-line).

	# Define tu línea de comando
	bowtie2 -x reference -U sample01.fastq -S sample01.sam -q -N 1 --n-ceil --end-to-end --threads 6

3.- Crea un archivo con extensión `.bash` usando el comando `vim` y escribe las instrucciónes del ciclo, usarémos `while`, así:

	$ vi bowtie2.bash
	# En la terminal se abrirá el archivo bowtie2.bash...
	# Presiona la tecla i para poder editar y escribe:
	
	while read sample
	do

		bowtie2 -x ../reference/Gaculeatus_reference -U ../etapa_1/"$sample".fastq -S "$sample".sam -q -N 1 --n-ceil --end-to-end --threads 6
	
	done < samples_list
	
	# Presiona la tecla esc para salir del editor y escribe:
	:wq
	# Lo que te permite guardar y salir del archivo bowtie2.bash

... algo así:

![vi_bowtie2.bash](https://github.com/microgenomics/Workshop-PUC/blob/master/images/vi_bowtie2-bash.png?raw=true) 

4.- Corre tu nuevo programa `bowtie2.bash`, de esta manera se realizará un alineamiento después del otro de forma automática, así:

	$ bash bowtie2.bash

... verás que `bowtie2` comienza a trabajar e irá reportando algúnas estadísticas acerca de cada alineamiento, como se ve en la siguiente imágen:

![run_bowtie2](https://github.com/microgenomics/Workshop-PUC/blob/master/images/run_bowtie2.png?raw=true)

Dependiendo las capacidades de tu computadora, a `bowtie2` le podría tomar de 30 minutos a 1 hora desarrollar los 18 alineamientos de los datos ejemplo. Una vez que termine, deberías ver los siguientes *outputs*:

	$ ls
	cr_1533-05.sam   cs_1335-54.sam   pcr_1211-11.sam
	pl_1537-27.sam   sj_1879-31.sam   stl_1274-72.sam
	cr_1533-17.sam   ms_2067-51.sam   pcr_1312-13.sam
	rb_2240-128.sam  sj_1879-34.sam   wc_1218-07.sam
	cs_1335-17.sam   ms_2067-66.sam   pl_1537-11.sam
	rb_2240-158.sam  stl_1274-63.sam  wc_1221-02.sam

SAM (*Sequence Alignment/Map*) es un formato de archivos que incluye toda la información acerca de un alineamiento de *reads* contra largas sequencias de referencia, puedes leer al respecto [aquí](https://samtools.github.io/hts-specs/SAMv1.pdf).

+ Puedes descargar los 18 archivos SAM [aquí]().

Ahora que tienes los archivos SAM (alineamientos) de cada muestra, estás listo para seguir adelante con la *pipeline* y realizar los análisis de genética poblacional.

#### *De Novo*
