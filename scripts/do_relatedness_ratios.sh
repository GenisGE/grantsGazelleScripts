#!/bin/sh


nairobi_ids=/home/genis/grants/index_txt_files/inds/by_pop/nairobi_ids
bams_folder=/home/genis/grants/data/bamfiles
use_sites_nairobi=/home/genis/grants/index_txt_files/sites/by_pop/sites_to_keep_nairobi.txt
use_sites_granti=/home/genis/grants/index_txt_files/sites/by_pop/sites_to_keep_monduli.txt
use_sites_notata=/home/genis/grants/index_txt_files/sites/by_pop/sites_to_keep_notata.txt
out_folder=/home/genis/grants/analyses/relatedness_ratios
saf_folder=$out_folder/saf_files
cow_genome=/home/genis/grants/data/cow_genome/bosTau8.fa
realSFS=/home/genis/software/angsd/misc/realSFS
angsd=/home/genis/software/angsd/angsd

mkdir $saf_folder

# granti weird inds Masai_open 2827 2828 Burunge 3915
# notata sibiloi 316 317

for ind in 2827 2828 3915
do
    $angsd -i $bams_folder/$ind.bam -anc $cow_genome -sites $use_sites_granti -GL 2 -doSaf 1 -minQ 20 -minMapQ 30 -out $saf_folder/$ind
done

# two notata sibiloi individuals
for ind in 316 317
do
    $angsd -i $bams_folder/$ind.bam -anc $cow_genome -sites $use_sites_notata -GL 2 -doSaf 1 -minQ 20 -minMapQ 30 -out $saf_folder/$ind
done

$realSFS $saf_folder/316.saf.idx $saf_folder/317.saf.idx -P 20 > $out_folder/316_317.2dsfs
$realSFS $saf_folder/2827.saf.idx $saf_folder/2828.saf.idx -P 20 > $out_folder/2827_2828.2dsfs
$realSFS $saf_folder/2827.saf.idx $saf_folder/3915.saf.idx -P 20 > $out_folder/2827_3915.2dsfs
$realSFS $saf_folder/2828.saf.idx $saf_folder/3915.saf.idx -P 20 > $out_folder/2828_3915.2dsfs

# granti individuals from Nairobi
cat $nairobi_ids | while read ind; do
	$angsd -i $bams_folder/$ind.bam -anc $cow_genome -sites $use_sites -GL 2 -doSaf 1 -minQ 20 -minMapQ 30 -out $saf_folder/$ind
done

$realSFS $saf_folder/291.saf.idx $saf_folder/292.saf.idx -P 20 > $out_folder/291_292.2dsfs
$realSFS $saf_folder/291.saf.idx $saf_folder/293.saf.idx -P 20 > $out_folder/291_293.2dsfs
$realSFS $saf_folder/291.saf.idx $saf_folder/294.saf.idx -P 20 > $out_folder/291_294.2dsfs
$realSFS $saf_folder/291.saf.idx $saf_folder/295.saf.idx -P 20 > $out_folder/291_295.2dsfs
$realSFS $saf_folder/292.saf.idx $saf_folder/293.saf.idx -P 20 > $out_folder/292_293.2dsfs
$realSFS $saf_folder/292.saf.idx $saf_folder/294.saf.idx -P 20 > $out_folder/292_294.2dsfs
$realSFS $saf_folder/292.saf.idx $saf_folder/295.saf.idx -P 20 > $out_folder/292_295.2dsfs
$realSFS $saf_folder/293.saf.idx $saf_folder/294.saf.idx -P 20 > $out_folder/293_294.2dsfs
$realSFS $saf_folder/293.saf.idx $saf_folder/295.saf.idx -P 20 > $out_folder/293_295.2dsfs
$realSFS $saf_folder/294.saf.idx $saf_folder/295.saf.idx -P 20 > $out_folder/294_295.2dsfs
