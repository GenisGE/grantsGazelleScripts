
out_folder=/home/genis/grants/analyses/new130320NoRecAdmix/fst/byChrOnlyMales
saf_folder=$out_folder/saf_files
sfs_folder=$out_folder/2dsfs/
fst_folder=$out_folder/fst

info_folder=/home/genis/grants/index_txt_files/inds/no_rec_admix/by_pop_onlyMales
sites_folder=/home/genis/grants/index_txt_files/sites/by_pop
cow_genome=/home/genis/grants/data/cow_genome/bosTau8.fa

angsd=/home/genis/software/angsd/angsd
realSFS=/home/genis/software/angsd/misc/realSFS

mkdir $out_folder
mkdir $saf_folder
mkdir $sfs_folder
mkdir $fst_folder
mkdir $fst_folder/binary

# Do per pop and per chr saf, using only males and -isHap 1 for X chromosome
cat $info_folder/pops_list.txt | while read pop;
do
    n="$(wc -l $info_folder/bams_${pop}_males.txt | cut -f1 -d" ")"
    half=$(($n/2))
    
    for i in `seq 1 15` `seq 17 29`
    do
	$angsd -bam $info_folder/bams_${pop}_males.txt -anc $cow_genome -gl 2 -doSaf 1 -doCounts 1 -setMaxDepth 5000 -minMapQ 30 -minQ 20 -minInd $half -sites $sites_folder/sites_to_keep_$pop.txt -nThreads 20 -r chr$i -out $out_folder/saf_files/${pop}_chr$i
    done
    
    $angsd -bam $info_folder/bams_${pop}_males.txt -anc $cow_genome -gl 2 -doSaf 1 -doCounts 1 -setMaxDepth 5000 -minMapQ 30 -minQ 20 -minInd $half -sites $sites_folder/sites_to_keep_$pop.txt -nThreads 20 -r chrX -out $out_folder/saf_files/${pop}_chrX -isHap 1

done


#Do per pair of pops 2DSFS and FST
cat $info_folder/pop_pairs.info | while read pair
do
    pop1="$(echo $pair | cut -f1 -d".")"
    pop2="$(echo $pair | cut -f2 -d".")"

    for i in `seq 1 15` `seq 17 29` X; do
	$realSFS $saf_folder/${pop1}_chr$i.saf.idx $saf_folder/${pop2}_chr$i.saf.idx -P 20 > $sfs_folder/${pair}_chr$i.ml
	$realSFS fst index $saf_folder/${pop1}_chr$i.saf.idx $saf_folder/${pop2}_chr$i.saf.idx -sfs $sfs_folder/${pair}_chr$i.ml -whichFst 1 -fstout $fst_folder/binary/${pair}_chr$i
	$realSFS fst stats $fst_folder/binary/${pair}_chr$i.fst.idx > $fst_folder/${pair}_chr${i}.fst2
    done
        
done
