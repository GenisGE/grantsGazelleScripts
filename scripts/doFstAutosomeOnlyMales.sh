angsd=/home/genis/software/angsd/angsd
realSFS=/home/genis/software/angsd/misc/realSFS

pop_inf=/home/genis/grants/index_txt_files/inds/no_rec_admix/by_pop_onlyMales
cow_genome=/home/genis/grants/data/cow_genome/bosTau8.fa
sites_folder=/home/genis/grants/index_txt_files/sites/autosome_sites

out_dir=/home/genis/grants/analyses/new130320NoRecAdmix/fst/autosome_onlyMales
saf_folder=$out_dir/saf_files
sfs_folder=$out_dir/2dsfs
fst_folder=$out_dir/fst
sites_folder=/home/genis/grants/index_txt_files/sites/autosome_sites

mkdir $saf_folder
mkdir $sfs_folder
mkdir $fst_folder
mkdir $fst_folder/binary

cat $pop_inf/pops_list.txt | while read pop;
do
    n="$(wc -l $pop_inf/bams_${pop}_males.txt | cut -f1 -d" ")"
    half=$(($n/2))
    
    $angsd -bam $pop_inf/bams_${pop}_males.txt -anc $cow_genome -gl 2 -doSaf 1 -doCounts 1 -setMaxDepth 5000 -minMapQ 30 -minQ 20 -minInd $half -sites $sites_folder/autosome_sites_to_keep_nochr16_$pop.txt -nThreads 30 -out $saf_folder/${pop}
done

# Do 2dsfs from cow ancestral saf files, use it to estimate global fsts
cat $pop_inf/pop_pairs.info | while read pair
do
   pop1="$(echo $pair | cut -f1 -d".")"
   pop2="$(echo $pair | cut -f2 -d".")"

   $realSFS $saf_folder/${pop1}.saf.idx $saf_folder/${pop2}.saf.idx -P 30 > $out_dir/2dsfs/$pair.2dsfs
    
   $realSFS fst index -whichFst 1 $saf_folder/${pop1}.saf.idx $saf_folder/${pop2}.saf.idx -P 30 -sfs $out_dir/2dsfs/$pair.2dsfs -fstout $fst_folder/binary/$pair

    $realSFS fst stats $fst_folder/binary/$pair.fst.idx > $fst_folder/$pair.fst
    
done
