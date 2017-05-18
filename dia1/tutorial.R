source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")

library(phyloseq)
library(ggplot2)

#remember have metadata file according to pathoscope_table

df<-read.csv(file.choose(),header = T) #read the main table
head(df)
nrow(df)
ncol(df)
tail(df)
names(df)
index <- rowSums(df[,8:21])>1
df<-df[index,]

metad<-read.csv("metadata.csv",header = T,row.names = 1)#read the metadata
metad<-sample_data(metad)#convert table into sample data (for phyloseq object)
tax<-tax_table(as.matrix(df[,1:7]))#get cols that only have taxa names
otu<-otu_table(as.matrix(df[,c(8:ncol(df))]),taxa_are_rows = T)#get cols that have the values
phyob<-phyloseq(otu, tax,metad)#finally make phyloseq object

plot_bar(phyob, fill = "Phylum")
plot_bar(phyob, "Phylum",fill = "Phylum", facet_grid =~host_disease)

phydist<-distance(phyob,"jaccard")
phyord<-ordinate(phyob, "MDS", distance = phydist)

plot_ordination(phyob, phyord, type = "sample",color = "host_disease")
