#!/bin/bash

beagle_file=/home/genis/grants/analyses/gl_beagle/gl_hwe_filter.beagle.gz
out_folder=/home/genis/grants/analyses/pca
pcangsd=/home/genis/software/pcangsd/pcangsd.py

python $pcangsd -beagle $beagle_file -e 5 -o $out_folder/pca_hwefilter_e5 -threads 20
