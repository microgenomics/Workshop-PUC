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

## Ahora analiza tus propios datos !!

### Estapa 1: Pre-procesamiento de *reads*

El pre-procesamiento de los *reads*, obtenidos desde el proceso de secuenciación (*raw data*), consiste en identificar los *reads* de cada individuo (*demultiplex*) y recuperarlos en archivos FASTQ independientes. Además de realizar el control de calidad (QC: *quality control*), para descartar los *reads* de baja calidad.

Primero utiliza `-h` para conocer todas las opciónes disponibles en el programa `process_radtags`:

	$ process_radtags -h

Ahora escribe tu línea de commando y presiona `ENTER` ...

	$ 

