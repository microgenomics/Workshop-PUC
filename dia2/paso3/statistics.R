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
#el segundo paso es entonces obtener la mitad de nuestro genoma.
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
