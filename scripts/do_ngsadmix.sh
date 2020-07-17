#!/bin/sh

NGSadmix=/home/genis/software/NGSadmix

beagle_file=/home/genis/grants/analyses/gl_beagle/gl_hwe_filter.beagle.gz
nfile=ngsadmix_result
num=100  # Iterations to do
P=20 #number of cores
out=/home/genis/grants/analyses/admixture/ngsadmix/K$1
K=$1


mkdir $out
rm $out/*

for f in `seq $num`
do
	$NGSadmix -likes ${beagle_file} -seed $f -K $K -P $P -o $out/${nfile}_${K}_$f
	grep "like=" ${out}/${nfile}_${K}_${f}.log | cut -f2 -d" " | cut -f2 -d"=" >> ${out}/${nfile}_${K}.likes
done
