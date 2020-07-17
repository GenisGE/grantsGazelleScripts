#!/bin/bash

angsd=/home/genis/software/angsd/angsd
bams_list_no_outgroup=/home/genis/grants/index_txt_files/inds/bams_over_50bp_final_filters_subset1.txt
bams_list_with_outgroup=/home/genis/grants/index_txt_files/inds/bams_over_50bp_final_filters_with_outgroup.txt
out_folder=/home/genis/grants/analyses/genotype_calling

$angsd -bam $bams_list_with_outgroup -doGeno -4 -doPlink 2 -GL 2 -minMapQ 30 -minQ 20 -doMaf 1 -doPost 2 -SNP_pval 1e-6 -doCounts 1 -doMajorMinor 1 -geno_minDepth 8 -minInd 52 -setMaxDepth 5000 -out $out_folder/genos_final_inds_filts_with_outgroup_test1_minInd52 -P 20


# this outputs a .tped file,  you will need further steps to process it (filter unknown chomsomes, maf filters...) I did that with PLINK
