#!/bin/bash

angsd=/home/genis/software/angsd/angsd
bams_thomson=/home/genis/grants/index_txt_files/inds/by_pop/bams_thomson.txt
out_folder=/home/genis/grants/data/thomson_genome

$angsd -doFasta 2 -doCounts 1 -b $bams_thomson -minQ 20 -minMapQ 30 -P 20 -out $out_folder/thom_ref -seed 17
