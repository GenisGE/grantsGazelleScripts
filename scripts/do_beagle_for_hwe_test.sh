#!/bin/sh

bam_files=/home/genis/grants/index_txt_files/inds/bams_over_50bp_final_filters_subset1.txt
out_file=/home/genis/grants/analyses/gl_beagle/first_gl_no_hwe

angsd -GL 2 -bam $bam_files -out $out_file -minInd 50 -minQ 20 -minMapQ 30 -SNP_pval 1e-6 -doMaf 1 -minMaf 0.05 -nThreads 20 -doGlf 2 -doMajorMinor 1 -P 20
