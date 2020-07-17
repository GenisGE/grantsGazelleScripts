#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly=T)
filename <- args[1]

pl <- read.table(filename, header=T)

print("Loaded file")
trmx <- matrix(ncol=length(unique(pl$CLST)), nrow=dim(pl)[1]/length(unique(pl$CLST)))
colnames(trmx) <- unique(pl$CLST)
print("Created output file")
for(pop in unique(pl$CLST)){

	print("beginning loop")
	min <- pl$MAC[which(pl$CLST==pop)]
	tot <- pl$NCHROBS[which(pl$CLST==pop)]
	maj <- tot - min
	print("Going to write value")
	trmx[,pop] <- paste(maj, min, sep=",")
	print("written value to table")

}

write.table(trmx, paste(filename, ".input_treemix", sep=""), quote=F, row.names=F, col.names=T)
