# Preprocesamiento de datos propios, Control de calidad. Análisis básicos en R

En este práctico aprenderemos los pasos esenciales que se deben realizar para obtener un buen ensamble a partir de lecturas de una secuenciación (reads), se debe tener en cuenta que mientras más buena sea una secuenciación, mejor será su ensamble.

Requisitos:

* fastQC >= v0.11.5
* Prinseq-lite >= v0.20.4
* SPAdes >= v3.10.1
* Quast >= v4.1
* Bowtie2 >= v2.2.9
* Samtools >= v1.3.1
* Bedtools >= v2.26.0
* R >= v3.3.1
	* ggplot2

### Paso 1: Revisar calidad de los reads

El primer paso (siempre), antes de trabajar con reads es obtener algunas estadísticas que nos dirán que tan bien resulto nuestra secuenciación, para esto usaremos FastQC, un programa escrito en java y que rápidamente nos puede otorgar estadísticas acerca del estado de nuestros reads.

	#crearemos una carpeta llamada paso1
	mkdir paso1
	#copia tus secuencias dentro de la carpeta paso1
	Abrir fastQC.
	File -> Open -> seleccionar pg_R1.fastq y pg_R2.fastq.

La principal ventana que nos interesa es la calidad que tiene nuestra secuenciación, y en general, una calidad (Q) sobre 20 se considera buena.
![](../images/fastqc1.png)
El %GC lo usamos para corroborar que lo que se secuenció sea efectivamente lo que queremos, para eso, ambas curvas (teórica y real), deben ser similares.
![](../images/fastqc2.png)
Al principio y al final de nuestros reads se nota un aumento en la frecuencia de k-mers (errores de secuenciación?)
![](../images/fastqc3.png)

Para ver el detalle completo puedes descargarlo: ![aquí](../checkpoints/paso2/pg_R1_antes.html.zip)

Para todas estas correcciones, usaremos "prinseq"

### Paso 2: Control de calidad
prinseq es un software open source escrito en perl famoso por su versatilidad en el manejo de reads.

Directo al grano
	
	#creamos una carpeta llamada paso2
	mkdir paso2
	#entramos en la carpeta
	cd paso2
	#y acontinuación ejecutamos la línea de comando:
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

Las reads que pasan el control de calidad, son puestas en un nuevo archivo llamado **pass\_1.fastq, pass\_2.fastq, pass\_1\_singletons.fastq y pass\_2\_singletons.fastq**, pero a nosotros solo nos interesa los archivos que tengan las lecturas emparejadas

Ahora podemos ver el estado de las reads que pasaron el filtro:

	Abrir fastQC.
	File -> Open -> seleccionar pass_1.fastq y pass_2,fastq

Vemos que el número de bases de mala calidad se ha reducido
![](../images/fastqc4.png)

y también el numero anormal de k-mers
![](../images/fastqc5.png)

en otras palabras, hemos hecho el control de calidad (QC) a nuestras reads. Hurra!

## Paso 3: Ensamble
Ensamblar un genoma se refiere a la unión de todas las reads en un súper read muy largo llamado "Contig", y a su vez, estos contigs se tratan de unir en contigs aun mas largos llamados "scaffolds".

**Recordatorio: nunca se obtendrá un solo scaffolds que represente todo el genoma circular de la bacteria a menos que sea secuenciada con mas de una tecnología.**

Para esto usaremos un software llamado SPAdes el cual funciona de la siguiente manera:

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
	
Una vez terminado el ensamble, nuestros scaffolds están en la carpeta pg_assembly (creada por SPAdes) en el archivo llamado scaffolds.fasta

aquí haremos una pequeña limpieza y eliminar todos aquellos contigs que tengan menos de 500 bases.

para ello ejecutaremos el siguiente comando:

	#entrar en la carpeta del ensamble
	cd pg_assembly
	awk 'BEGIN{RS=">";ORS=""}length($0)>500{print ">"$0}' scaffolds.fasta > filter500.fasta
	#salir de la carpeta del ensamble
	cd ..
	
Listo!, tenemos nuestro genoma ensamblado. Ya solo nos queda evaluar que tan bien salió.

para esto usaremos Quast, un software escrito en python que genera reportes estadísticos de ensambles:
	
	quast.py -t 16 pg_assembly/filter500.fasta 

Donde:

* -t es el número hilos que usara la CPU para generar nuestro reporte.

esto creará un nuevo directorio llamado "quast_results" y dentro de ello una carpeta llamada results\_XXXXXXXX (donde XXXXXXX es la fecha actual de ejecución de quast), la cual contiene nuestro reporte. Accederemos al reporte con un simple comando unix "cat"

	cat quast_results/results_2017_05_11_17_58_46/report.txt

y obtendremos el siguiente resultado:

	All statistics are based on contigs of size >= 500 bp, unless otherwise noted (e.g., "# contigs (>= 0 bp)" and "Total length (>= 0 bp)" include all contigs).

	Assembly                    filter500
	# contigs (>= 0 bp)         67       
	# contigs (>= 1000 bp)      56       
	# contigs (>= 5000 bp)      51       
	# contigs (>= 10000 bp)     45       
	# contigs (>= 25000 bp)     32       
	# contigs (>= 50000 bp)     14       
	Total length (>= 0 bp)      2268869  
	Total length (>= 1000 bp)   2261939  
	Total length (>= 5000 bp)   2247304  
	Total length (>= 10000 bp)  2208718  
	Total length (>= 25000 bp)  1986915  
	Total length (>= 50000 bp)  1371208  
	# contigs                   67       
	Largest contig              210009   
	Total length                2268404  
	GC (%)                      48.45    
	N50                         75957    
	N75                         32834    
	L50                         11       
	L75                         22       
	# N's per 100 kbp           21.56 
	
* En total son 67 contigs (contigs >= 0 bp), un valor muy bueno si consideramos que solo mandamos a secuenciar una sola vez nuestra bacteria y en la práctica, este valor es más alto.
* La cantidad total de bases también es buena en este caso, 2,268,869 (Total length) que se acerca mucho a los 2,354,886 que tiene el genoma de referencia de esta bacteria (Porphyromonas gingivalis ATCC 33277).
* El %GC de nuestro genoma también es un indicador que podemos usar para comprobar la similitud de nuestro genoma en este aspecto. 48.45% vs 48.4% es muy bueno.
* N50 es un número estadístico que nos mide la calidad de un ensamble, se define como: **Dado un numero X de contigs ordenados de mayor a menor, el N50 es el largo del contig cuya suma con los contigs anteriores se obtiene el 50% del largo total del genoma.** Y en este caso, tener un contig de largo 75957 es un buen indicador para nuestro ensamble.
* L50 es el número contigs que forman el N50. En este caso 11 contigs componen el 50% del genoma, esto es bueno ya que tenemos al menos la mitad del genoma en unos pocos contigs.

		#finalmente salimos de la carpeta paso3
		cd ..

## Paso 4: Mapeo y obtención de coverage

El termino Coverage (Cobertura) se define como el número de reads que cubren una base, es decir número de veces que se ha secuenciado una base.

¿Recuerdan las reads filtradas del paso 2?, las alinearemos con nuestro genoma ensamblado para saber cuantas veces se ha cubierto con nuestras reads, es decir cuanto coverage tiene nuestro ensamble.

para esto usaremos Bowtie2, un alineador muy rápido y flexible (además de usar eficientemente la memoria). Para ello primero necesitamos indexar nuestro genoma (convertirlo en un formato que bowtie2 pueda leer):

	#primero crearemos una carpeta para este cuarto paso
	mkdir paso4
	#entramos en la carpeta
	cd paso4
	bowtie2-build --threads 16 ../paso3/pg_assembly/filter500.fasta pg_index

Esto generará 6 archivos que representan el ensamble indexado para bowtie2. El siguiente paso es alinear los reads:

	bowtie2 -x pg_index -1 ../paso2/pass_1.fastq -2 ../paso2/pass_2.fastq -S pg.sam --end-to-end --very-sensitive

Esto nos dará un archivo SAM (Sequence Aligment Map) con toda la información del alineamiento, ([aquí puedes encontrar mas información acerca del formato SAM](https://samtools.github.io/hts-specs/SAMv1.pdf)). Por lo pronto, necesitamos transformar el formato SAM a BAM (Binary Aligment Map):

	samtools view -b -S pg.sam |samtools sort -@16 > pg.bam
	#now get the coverage per bp
	genomeCoverageBed -ibam pg.bam -g ../paso3/pg_assembly/filter500.fasta -d > all.txt
	
all.txt tiene el coverage por nucleótido a lo largo de nuestro genoma, así que, estamos listos para graficar!, para eso solo copia este feo pero útil código en Rstudio y ejecútalo.

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
	all.data <- read.csv("all.txt", header=FALSE, sep="\t",colClasses=column.types)
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
	  
Esto dará como resultado el siguiente gráfico:
![](../images/coverage_denovo.png)
Como vemos, el coverage a lo largo del genoma es homogéneo salvo algunas zonas pequeñas, quizás puede haber algo interesante allí.