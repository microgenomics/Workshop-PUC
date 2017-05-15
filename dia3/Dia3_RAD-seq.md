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

De ahora en adelante, puedes utilizar tus propios datos (los *reads* que recibiste en uno o varios archivos FASTQ directamente del proceso de secuenciación). Recuerda poner especial atención en los parámteros/opciónes disponibles en cada programa paso a paso. Siempre es importante saber que les ocurre a tus datos al correr cada programa, para ello debes conocer las opciónes disponibles y escoger las mas adecuadas para tu experimento. Puedes conocer los parámetros diponibles de cualquier programa usando la opción `-h` / `--help`, por ejemplo: `$ process_radtags -h`. Por supuesto, obtendrás más detalles y ejemplos si revisas la documentación del programa. Stacks cuenta con un manual detallado que puedes ver [aquí](http://catchenlab.life.illinois.edu/stacks/manual/#intro).
 
¿Aún esperas tus secuencias (*reads*)?... está bien, puedes utilizar los datos ejemplo que procesamos en el presente tutorial, éstos corresponden a los *reads* de un sub-muestreo que tomamos del estudio de [Catchen y cols., 2013](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3712868/?report=classic). BioProject [PRJNA195932](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA195932). En éste estudio se tomaron 590 muestras de ADN de la aletas caudal y ambas aletas pectorales de ejemplares de *Gasterosteus aculeatus* (pez espinoso o *the threespine stickleback fish* en inglés) en 9 zonas diferentes en las costas de Oregon, USA. En honor al tiempo, para este tutorial solo utilizaremos 18 muestras, 2 por cada zona.

> Catchen, J., Bassham, S., Wilson, T., Currey, M., O’Brien, C., Yeates, Q., & Cresko, W. A. (2013). The population structure and recent colonization history of Oregon threespine stickleback determined using RAD-seq. Molecular Ecology, 22(11), 2864–2883. http://doi.org/10.1111/mec.12330

+ Puedes descargar los archivos FASTQ [aquí](https://dl.dropboxusercontent.com/u/73361402/PRJNA195932_18subset.zip).

La siguiente tabla muestra algunos datos útiles sobre los archivos FASTQ que acabas de descargar, éstos tienen el mismo nombre que puedes ver en la columna `Sample_Name`, que corresponde al nombre que los autores le dieron a cada muestra. La columna `biome` corresponde al ambiente en dónde se tomaron las muestras, en este caso, océano y agua dulce. La columna `geographic_location` corresponde a la localización geográfica dónde se tomó cada muestra. Éstas son sólo un poco de la información diponible en la base de datos [SRA](https://www.ncbi.nlm.nih.gov/sra) (*Sequence Read Archive*) de [NCBI](https://www.ncbi.nlm.nih.gov), puedes descargar la tabla completa [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia3/PRJNA195932_SRA_table.xlsx).

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

### Etapa 1: Pre-procesamiento de *reads*

El pre-procesamiento de los *reads*, obtenidos desde el proceso de secuenciación (*raw data*), consiste en identificar los *reads* de cada individuo (*demultiplex*) y recuperarlos en archivos FASTQ independientes. Además de realizar el control de calidad (QC: *quality control*), para descartar los *reads* de baja calidad.

Primero utiliza `-h` para conocer todas las opciónes disponibles en el programa `process_radtags`:

	$ process_radtags -h

Ahora escribe tu línea de commando y presiona `ENTER` ...

	$ 

