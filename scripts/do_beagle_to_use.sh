#!/bin/bash

bam_files=/home/genis/grants/index_txt_files/inds/bams_over_50bp_final_filters_subset1.txt
out_file=/home/genis/grants/analyses/gl_beagle/gl_hwe_filter
use_sites=/home/genis/grants/index_txt_files/sites/sites_keep_hwe_e3.txt


angsd -GL 2 -bam $bam_files -out $out_file -sites $use_sites -P 20 -doGlf 2 -doMajorMinor 1
