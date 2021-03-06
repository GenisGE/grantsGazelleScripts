#!/bin/sh

pop_list=/home/genis/grants/index_txt_files/inds/by_pop/pops_list.txt
out_folder=/home/genis/grants/analyses/heterozygosities
calc_h=/home/genis/grants/scripts/calc_h.R

cat $pop_list | while read pop; do
	cat $out_folder/ind_sfs/$pop/*.sfs > all_sfs_$pop
	Rscript --vanilla $calc_h $pop
	ls $out_folder/ind_sfs/$pop/ | cut -f1 -d"." > bam_ids
	paste bam_ids $out_folder/${pop}_het.txt > $out_folder/${pop}_heterozygosities.txt
	rm bam_ids
	rm $out_folder/${pop}_het.txt
	rm all_sfs_$pop
done
