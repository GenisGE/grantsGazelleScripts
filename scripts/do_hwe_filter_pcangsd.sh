#!/bin/bash


pcangsd=/home/genis/software/pcangsd/pcangsd.py
beagle_file=/home/genis/grants/analyses/gl_beagle/first_gl_no_hwe.beagle.gz
out_folder=/home/genis/grants/analyses/hwe_test
e=3

python $pcangsd -beagle $beagle_file -inbreedSites -e $e -threads 20 -o $out_folder/hwe_test_e$e -sites_save
