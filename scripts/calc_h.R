#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly=T)
pop_name <- args[1]
sfs_filename<-paste("all_sfs_", pop_name, sep="")

sfs <- as.matrix(read.table(sfs_filename))
H <- sfs[,2]/rowSums(sfs)

write.table(H,sprintf("/home/genis/grants/analyses/heterozygosities/%s_het.txt", pop_name), col.names=F, row.names=F, quote=F)
