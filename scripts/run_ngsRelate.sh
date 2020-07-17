#!/bin/sh

angsd=/isdata/common/lpq293/angsd/angsd
ngsRelate=/isdata/common/lpq293/ngsRelate/ngsRelate
pops=/binf-isilon/common/lpq293/grants/index_txt_files/check_who_is_who_admixture/by_pop/pops_list.txt
bams_folder=/isdata/common/lpq293/grants/index_txt_files/check_who_is_who_admixture/by_pop/by_pop_for_relatedness
sites_folder=/isdata/common/lpq293/grants/index_txt_files/sites_lists/lists_sites_to_keep_by_pop
out_folder1=/isdata/common/lpq293/grants/analyses/relatedness_inbreeding/filter_by_sites/gl_f_files
out_folder2=/isdata/common/lpq293/grants/analyses/relatedness_inbreeding/filter_by_sites/relate_inbreed_final

mkdir $out_folder1
mkdir $out_folder2
rm -r $out_folder1/*
rm -r $out_folder2/*

cat $pops | while read line; do
        n="$(wc -l $bams_folder/bams_$line.txt | cut -f1 -d" ")"
        half=$(($n/2))
	        $angsd -bam $bams_folder/bams_$line.txt -gl 2 -doGlf 3 -doMajorMinor 1 -doMaf 1 -minmaf 0.05 -minMapQ 30 -minQ 20 -minInd $half -dosnpstat 1 -doHWE 1 -hwe_pval 1e-6 -SNP_pval 1e-6 -sites $sites_folder/sites_to_keep_$line.txt -nThreads 20 -out $out_folder1/$line

        zcat $out_folder1/$line.mafs.gz | cut -f5 | sed 1d > freq
	$ngsRelate -g $out_folder1/$line.glf.gz -f freq -n $n > $out_folder2/${line}_res

done
