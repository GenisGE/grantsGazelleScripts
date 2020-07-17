out=/home/genis/grants/analyses/depths/checkSex
use_sites=/home/genis/grants/index_txt_files/sites/sites_keep_hwe_e3.txt
in_folder=/home/genis/grants/index_txt_files/inds/by_pop
pop_list=$in_folder/pops_list.txt

cat $pop_list | while read pop
do
    n="$(wc -l $in_folder/bams_$pop.txt | cut -f1 -d" ")"
    half=$(($n/     angsd -bam $in_folder/bams_$pop.txt  -doDepth 1 -doCounts 1 -minQ 20 -minMapQ 30 -minInd $half -r chr17 -out $out/depth_chr17_$pop -P 20
    angsd -bam $in_folder/bams_$pop.txt  -doDepth 1 -doCounts 1 -minQ 20 -minMapQ 30 -minInd $half -r chrX -out $out/depth_chrX_$pop -P 20
    angsd -bam $in_folder/bams_$pop.txt  -doDepth 1 -doCounts 1 -minQ 20 -minMapQ 30 -minInd $half -r chr1 -out $out/depth_chr1_$pop -P 20

done

