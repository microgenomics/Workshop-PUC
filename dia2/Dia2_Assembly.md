# Preprocesamiento de datos propios, Control de calidad. Análisis básicos en R

En este práctico aprenderemos los pasos esenciales que se deben realizar para obtener un buen ensamble, tanto si lo hacemos *denovo* o si utilizamos una *referencia*, a partir de lecturas de una secuenciación (**reads**). Se debe tener en cuenta que mientras más buena sea una secuenciación, mejor será su ensamble.

Requisitos:

* fastQC >= v0.11.5
* Prinseq-lite >= v0.20.4
* SPAdes >= v3.10.1
* Quast >= v4.1
* Bowtie2 >= v2.2.9
* Samtools >= v1.3.1
* Bedtools >= v2.26.0
* Prokka >= v1.12
* R >= v3.3.1
	* ggplot2
* Reads: Si no tienes lecturas de secuenciación, puedes descargar las que se usaron en este workshop [aquí](#)

### Paso 1: Revisar calidad de los reads

El primer paso (siempre), antes de trabajar con reads es obtener algunas estadísticas que nos dirán que tan bien resultó nuestra secuenciación, para esto usaremos FastQC, un programa escrito en java y que rápidamente nos puede otorgar estadísticas acerca del estado de nuestros reads.

	#crearemos una carpeta llamada paso1
	mkdir paso1
	#mueve tus secuencias a la carpeta paso1
	#puedes hacerlo arrastrando los archivos a la carpeta como una persona normal, o puedes usar la terminal de tu computadora como los creadores del ramsomware que infectó a Movistar hace unos días.
	mv *.fastq paso1/.
	#Abrir fastQC
	File -> Open -> seleccionar pg_R1.fastq y pg_R2.fastq.

Aunque en este paso solo veremos algunas secciones del reporte, al final dejaremos el archivo disponible para que puedas descargarlo y analizarlo con mas tiempo. Ahora la principal ventana que nos interesa es la calidad que tiene nuestra secuenciación, y en general, una calidad (Q) sobre 20 se considera buena, ¿porqué?: El valor Q se define como una propiedad que está logaritmicamente relacionada con la probabilidad de que una base nucleotídica sea mal secuenciada, Q = -10log(P). Así, un valor Q   de 20 significaría un error de 1 base cada 100, dando una precisión del 99%. y viendo nuestro reporte, tenemos una buena secuenciación.
![](../images/fastqc1.png)
Otro aspecto que vale la pena revisar es el **%GC** (contenido Guanina-Citosina), un valor usado para clasificar organismos y en este caso para corroborar que lo que se secuenció sea efectivamente lo que queremos, para eso ambas curvas (teórica y real), deben ser similares y de un solo peak.
![](../images/fastqc2.png)
FastQC en este caso nos dice que hay algo malo con el contenido de Kmer (un Kmer se puede definir como todos los sub-read de nuestro read de largo definido y usado en diferentes aplicaciones. [Para ver mas información acerca de los Kmer pinche aquí](https://en.wikipedia.org/wiki/K-mer)).

Volviendo a lo nuestro, al principio y al final de nuestros reads se nota un aumento en la frecuencia de k-mers (errores de secuenciación?), este comportamiento es frecuente cuando se secuencia con tecnología illumina y puede ser corregido haciendo un pequeño corte en los extremos de las secuencias.
![](../images/fastqc3.png)

Para ver en detalle el reporte completo puedes descargarlo [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso1/pg_R1_antes.html.zip)

### Paso 2: Control de calidad
Para realizar las correcciones que observamos en el paso 1, usaremos "prinseq", un software open source escrito en perl famoso por su versatilidad en el manejo de reads.

Directo al grano
	
	#creamos una carpeta llamada paso2
	mkdir paso2
	#entramos en la carpeta
	cd paso2
	#y a continuación ejecutamos la línea de comando:
	prinseq-lite.pl -fastq ../paso1/pg_R1.fastq -fastq2 ../paso1/pg_R2.fastq -out_good pass -out_bad null -trim_left 10 -trim_right 20 -trim_qual_right 20 -min_len 75 -trim_qual_window 15  -trim_qual_step 5 -ns_max_n 0
	#salimos de la carpeta paso2
	cd ..

Donde:

* -fastq es el nombre del primer archivo fastq.
* -fastq2 es el nombre del segundo archivo fastq.
* -out\_good imprime solo las secuencias que pasan el control de calidad que se ha establecido.
* -out\_bad imprime las secuencias que no pasaron el control de calidad, como en este es null, no se imprimirán).
* -trim\_left corta N bases a la izquierda de la secuencia.
* -trim\_right corta N bases a la derecha de la secuencia
* -trim\_qual\_right corta bases a la derecha hasta que se encuentre con una calidad superior a la especificada.
* -min_len filtra las reads por un tamaño N
* -trim\_qual\_window es el numero de bases en los que se trabajará para revisar la calidad 
* -trim\_qual\_step cuantas bases avanzara la ventana de trim\_qual\_windows
* -ns\_max\_n número máximo de Ns permitidas.

Las reads que pasan el control de calidad, son puestas automáticamente en un nuevo archivo llamado **pass\_1.fastq, pass\_2.fastq, pass\_1\_singletons.fastq y pass\_2\_singletons.fastq**, pero a nosotros solo nos interesa los archivos que tengan las lecturas emparejadas, es decir: **pass\_1.fastq, pass\_2.fastq**.

Ahora podemos ver el estado de las reads que pasaron el filtro y compararlas con las del paso 1 haciendo una especie de fotografía  antes y después:

	Abrir fastQC.
	File -> Open -> seleccionar pass_1.fastq y pass_2.fastq

Vemos que el número de bases de mala calidad se ha reducido, tiene sentido ya que le dimos la instrucción a prinseq para cortar las reads que no cumplan con un valor Q=20.
![](../images/fastqc4.png)

El número anormal de kmers también desapareció con el tratamiento y aunque aun existe un tendencia en el aumento de frecuencia de estos al final del gráfico, el orden de magnitud fue ampliamente reducido en comparación con el "antes".
![](../images/fastqc5.png)

en otras palabras, hemos hecho el control de calidad (QC) a nuestras reads. Hurra!, si quieres revisar en detalle como resultó el proceso puedes descargar el archivo pinchando [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso2/pg_R1_despues.html.zip)

##Paso 3: Ensamble
En simples palabras cuando se tienen reads ya procesadas, uno puede escoger entre 2 caminos para obtener un genoma, un ensamble **denovo** o un ensamble **con referencia**:

* **Denovo**: significa que nuestras reads se unieran entre ellas mediante overlapping, hasta formar un super gran read (o varios), que represente el genoma en cuestión.
* **Con referencia**: aquí nuestras reads se alinearán con algún genoma ya existente usándose como plantilla, obteniéndose un genoma con las mismas características estructurales de la plantilla (posición de genes, largo del genoma, etc).


### Paso 3.1: *Denovo*
Ya obtenidas nuestras reads de confianza, el siguiente paso es ensamblarlas. Ensamblar un genoma se refiere a la unión de todas las reads en un súper read muy largo llamado "Contig", y a su vez, estos contigs se tratan de unir en contigs aun mas largos llamados "scaffolds", todo esto con el fin de obtener el cromosoma completo de nuestro organismo.

**Recordatorio: nunca se obtendrá un solo scaffolds que represente todo el genoma circular de la bacteria (o algún otro organismo) a menos que sea secuenciada con mas de una tecnología.**

Para esto usaremos un software llamado SPAdes, un software desarrollado en python que mediante gráficos de brujin (haciendo uso de kmers), ensambla nuestras reads. Debemos tener en cuenta que el proceso de ensamble requiere mucha memoria RAM, aproximadamente unos 8GB para pequeñas secuenciaciones, y en este caso se necesitan 16GB de RAM, **es por esto que al final de este paso te damos el ensamble hecho!** :

	#crear carpeta paso3
	mkdir paso3
	#entrar en la carpeta
	cd paso3
	spades.py -1 ../paso2/pass_1.fastq -2 ../paso2/pass_2.fastq -t 16 -m 32 -o pg_assembly --careful --cov-cutoff auto
	
Done: 

* -1 es la secuencia forward de nuestros reads.
* -2 es la secuencia reverse de nuestros reads
* -t es el número de hilos que la CPU de nuestro computador usará
* -m es la memoria RAM que especificamos a SPAdes
* -o es el output de nuestro ensamble (carpeta donde estarán los resultados
* --careful parámetro para reducir el número de reads mal ensambladas
* --cov-cutoff es un limite de coverage que aceptaremos, valores inferiores serán descartados
	
Una vez terminado el ensamble (despues de alrededor de 30 minutos dependiendo del PC), nuestros scaffolds están en la carpeta pg_assembly (creada por SPAdes) en el archivo llamado scaffolds.fasta

aquí haremos una pequeña limpieza y eliminar todos aquellos contigs que tengan menos de 500 bases.

para ello ejecutaremos el siguiente comando:

	#entrar en la carpeta del ensamble
	cd pg_assembly
	awk 'BEGIN{RS=">";ORS=""}length($0)>500{print ">"$0}' scaffolds.fasta > filter500.fasta
	#salir de la carpeta del ensamble
	cd ..
	
Listo!, tenemos nuestro genoma ensamblado. Si no pudiste obtener tu ensamble por falta de recursos, puedes descargar el resultado de este paso pinchando [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso3/pg_assembly/filter500.fasta).


###Paso 3.2: Estadísticas básicas para un ensamble denovo

Ya solo nos queda evaluar que tan bien salió nuestro ensamble. Para esto utilizaremos Rstudio, una interfaz gráfica para el código R con el que manipularemos nuestro ensamble, esto mediante la libreria "ape".


	#ingresamos a la carpeta paso3
	cd paso3

Ahora abre Rstudio y crea un nuevo R script.
![](../images/rstudio.png)

copia y pega el siguiente código en tu hoja en blanco y sigamos pero ahora desde el script. Si llegaras a tener problemas con Rstudio, te dejamos el script [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso3/statistics.R)

```
library(ape)

#cambiamos la ruta de nuestro ensamble de acuerdo nuestro caso.
MyAssemblyPath<-"~/Desktop/Workshop-PUC/dia2/paso3/pg_assembly/filter500.fasta"

myassembly<-read.dna(MyAssemblyPath,format = "fasta",as.character = T)

##################################################
#calcular el total de contigs de nuestro ensamble#
##################################################
total_contigs<-length(myassembly)
total_contigs #67
#En total son 67 contigs, un valor muy bueno si consideramos que nuestra muestra solo se ha secuenciado una sola vez nuestra bacteria y en la práctica, este valor es más alto.

######################################################
#calcular el largo total (en bp), de nuestro ensamble#
######################################################
#primero obtendremos el largo de cada uno de nuestros contigs
largo_contigs<-sapply(myassembly,function(x){length(x)})
#podemos graficar rapidamente como es la distribución del largo
plot(largo_contigs)
#y podemos guardar este gráfico en el boton Export del lado derecho de Rstudio, justo arriba del gráfico.
#ahora sumaremos todos los largos
largo_total<-sum(largo_contigs)
largo_total #2268869
#La cantidad total de bases también es buena en este caso, 2,268,869 (Total length) que se acerca mucho a los 2,354,886 que tiene el genoma de referencia de esta bacteria (Porphyromonas gingivalis ATCC 33277).


##################################
#calcular %GC de nuestro ensamble#
##################################
gccontent<-GC.content(as.DNAbin(myassembly))
gccontent #0.4845348
#El %GC de nuestro genoma también es un indicador que podemos usar para comprobar la similitud de nuestro genoma en este aspecto. 48.45% vs 48.4% (referencia) es muy bueno.

####################
#calcular valor N50#
####################
#N50 es un número estadístico que nos mide la calidad de un ensamble, se define como: Dado un numero X de contigs ordenados de mayor a menor, el N50 es el largo del contig cuya suma con los contigs anteriores se obtiene el 50% del largo total del genoma.
#de acuerdo a lo anterior, el primer paso sería ordenar los contigs de mayor a menor, pero SPAdes ya lo hizo por nosotros :D.
#el segundo paso es entonces obtener el 50% de nuestro genoma.
mitad<-largo_total/2
mitad #1134434

#el ultimo paso es ir sumando los contigs hasta obtener por lo menos el valor de 1134434 (mitad)
acumulacion<-0
for(N50 in largo_contigs){
  acumulacion<- acumulacion + N50
  if(acumulacion>=mitad){
    break
  }
}
N50 #75957
# En este caso, nuestro N50 sería: 75957. esta medida debemos complementarla con un valor L50, que nos dice cuantos contigs forman el N50.

####################
#calcular valor L50#
####################
acumulacion<-0
L50<-1
for(N50 in largo_contigs){
  acumulacion<- acumulacion + N50
  if(acumulacion>=mitad){
    break
  }
  L50<-L50+1
}
L50 #11

#En este caso 11 contigs componen el 50% del genoma, esto es bueno ya que tenemos al menos la mitad del genoma en unos pocos contigs.

```
Estas son solo algunas estadísticas básicas, también existen otras como el N90 (largo del contig cuya suma con el resto otorga el 90% del largo del genoma), L90 (suma de contigs que obtienen el N90), N's por cada 100kb, etc. Por el momento, estas son suficientes para concluir que tenemos un buen ensamble. Ya solo falta saber cuantas veces esta cubierto nuestro genoma.

###Paso 3.3: Ensamble con referencia


## Paso 4: Alineamiento de reads y obtención de coverage

El termino Coverage (Cobertura) se define como el número de reads que cubren una base, es decir número de veces que se ha secuenciado una base. Esta es una medida de calidad avanzada que nos dirá (dada la definición anterior), cuantas veces hemos secuenciado nuestro genoma.

¿Recuerdan las reads filtradas del paso 2?, las alinearemos con nuestro genoma ensamblado para saber cuantas veces se ha cubierto con nuestras reads, para esto usaremos Bowtie2, un alineador muy rápido y flexible (además de usar eficientemente la memoria). Para ello primero necesitamos indexar nuestro genoma (convertirlo en un formato que bowtie2 pueda leer):

	#primero crearemos una carpeta para este cuarto paso
	mkdir paso4
	#entramos en la carpeta
	cd paso4
	bowtie2-build --threads 16 ../paso3/pg_assembly/filter500.fasta pg_index

Esto generará 6 archivos que representan el ensamble indexado para bowtie2. El siguiente paso es alinear los reads, de cualquier forma, si no lograste indexar el genoma por A B C motivos, pincha [aquí](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso5/pg_index.zip) para descargarlos y ponerlos en la carpeta paso4

	bowtie2 -x pg_index -1 ../paso2/pass_1.fastq -2 ../paso2/pass_2.fastq -S pg.sam --end-to-end --very-sensitive

Esto nos dará un archivo SAM (Sequence Aligment Map) con toda la información del alineamiento, ([aquí puedes encontrar mas información acerca del formato SAM](https://samtools.github.io/hts-specs/SAMv1.pdf)). Por lo pronto, necesitamos transformar el formato SAM a BAM (Binary Aligment Map):

	samtools view -b -S pg.sam |samtools sort -@16 > pg.bam
	#now get the coverage per bp
	genomeCoverageBed -ibam pg.bam -g ../paso3/pg_assembly/filter500.fasta -d > all.txt
	
[all.txt](https://github.com/microgenomics/Workshop-PUC/raw/master/dia2/paso5/all.txt) tiene el coverage por nucleótido a lo largo de nuestro genoma, así que, estamos listos para graficar!, para eso solo copia este feo pero útil código en Rstudio y ejecútalo (pero ajusta la primera línea para que la ruta al archivo all.txt sea la correcta).

	alltxtPath<-"paso4/all.txt"
	
	library(ggplot2)

	slidingwindowplot <- function(windowsize, inputseq) {
	  starts <- seq(1, length(inputseq)-windowsize, by = windowsize)
	  n <- length(starts)
	  chunkbps <- numeric(n)
	  chunkstats<- numeric(n)
	  for (i in 1:n){
	    chunk <- inputseq[starts[i]:(starts[i]+windowsize-1)] 
	    chunkmean <- mean(chunk)
	    chunkstdv<-sd(chunk)
	    chunkbps[i] <- chunkmean
	    chunkstats[i]<-chunkstdv
	  }
	  return(list(starts,chunkbps,chunkstats))
	}
	
	binSize<-1000
	maxy<-max(df$sd)+10
	column.types <- c("character", "numeric", "numeric")
	all.data <- read.csv(alltxtPath, header=FALSE, sep="\t",colClasses=column.types)
	myvector_all<-as.vector(as.matrix(all.data[3]))
	windowAll<-slidingwindowplot(binSize,myvector_all)
	df<-data.frame(windowAll[[1]],windowAll[[2]],windowAll[[3]])
	colname<-c("x","mean","sd")
	colnames(df)<-colname
	eb <- aes(ymax = mean + sd, ymin = mean - sd) 
	
	
	ggplot(data = df, aes(x = x, y = mean)) +
	  geom_line(colour="#0066CC",size=0.5) + 
	  geom_ribbon(eb, alpha=.5, colour=NA,fill="#0066CC")+
	  theme_bw()+xlab("Reference Start Position")+
	  ylab("coverage")+scale_x_continuous(expand = c(0,0))+
	  scale_y_continuous(limits = c(0, maxy))+
	  ggtitle("Coverage Across Reference")
	  
Esto dará como resultado el siguiente gráfico que puedes guardar en la pestaña Export en el cuadro de la derecha de Rstudio:
![](../images/coverage_denovo.png)
Como vemos, el coverage a lo largo del genoma es homogéneo salvo algunas zonas pequeñas, y de acuerdo a la definición de este, tenemos que nuestro genoma esta cubierto aproximadamente 190 veces, un muy buen resultado.