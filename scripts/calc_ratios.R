#!/usr/bin/env Rscript
#Rsciprt calc_ratios.R ids.list
#takes input individual ids between which to calculate ratios. It is assumed in same folder as script is run there are 2dsfs between all individuals as outputed by realSFS and called ind1_ind2.2sfs

args <- commandArgs(trailingOnly=T)

id_file <- args[1]

ind_ids <- scan(id_file, what=1)

N <- length(ind_ids)

ratios <- matrix(ncol=5, nrow=(N*(N-1))/2)
colnames(ratios) <- c("ind1","ind2", "R0", "R1","KING")
count = 1

for(i in 1:(N-1)){
    for(j in (i+1):N){
      
        sfs2d <- scan(sprintf("%i_%i.2dsfs",ind_ids[i],ind_ids[j]),what=.3)
        
        r0 <- (sfs2d[3]+sfs2d[7])/sfs2d[5]
        r1 <- sfs2d[5]/(sfs2d[2] +sfs2d[3] +sfs2d[4] +sfs2d[6] +sfs2d[7] +sfs2d[8])
        king <- (sfs2d[5] - 2*(sfs2d[3]+sfs2d[7]))/(sfs2d[2]+sfs2d[4]+sfs2d[6]+sfs2d[8]+2*sfs2d[5])
        
        ratios[count,] <- c(ind_ids[i],ind_ids[j],r0,r1,king)
        count = count + 1
    }
}

write.table(ratios, paste("relatedness_ratios_",paste(ind_ids,collapse="_"),"fixedKINGR1.txt",sep=""), col.names=T, row.names=F, quote=F)
