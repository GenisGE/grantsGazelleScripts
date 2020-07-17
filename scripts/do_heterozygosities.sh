#!/bin/bash

angsd=/home/genis/software/angsd/angsd
realSFS=/home/genis/software/angsd/misc/realSFS
cow_genome=/home/genis/grants/data/cow_genome/bosTau8.fa
bams_folder=/home/genis/grants/data/bamfiles
pop_list=/home/genis/grants/index_txt_files/inds/by_pop/pops_list.txt
pops_info_folder=/home/genis/grants/index_txt_files/inds/by_pop
sites_info_folder=/home/genis/grants/index_txt_files/sites/by_pop
out_folder=/home/genis/grants/analyses/heterozygosities

mkdir $out_folder/ind_sfs
mkdir $out_folder/saf_files

cat $pop_list | while read pop; do
	mkdir $out_folder/ind_sfs/$pop
	cut -f3 -d" " $pops_info_folder/$pop.info | while read ind; do
		$angsd -i $bams_folder/$ind.bam -anc $cow_genome -GL 2 -doSaf 1 -minQ 20 -minMapQ 30 -sites $sites_info_folder/sites_to_keep_$pop.txt -out $out_folder/saf_files/$ind
		$realSFS $out_folder/saf_files/$ind.saf.idx -P 20 > $out_folder/ind_sfs/$pop/$ind.sfs
	done
done

