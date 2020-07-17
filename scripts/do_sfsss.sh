angsd=/home/genis/software/angsd/angsd
realSFS=/home/genis/software/angsd/misc/realSFS


pop_inf=/home/genis/grants/index_txt_files/inds/no_rec_admix/by_pop
out_dir=/home/genis/grants/analyses/new130320NoRecAdmix/sfss
saf_folder=$out_dir/saf_files
sites_folder=/home/genis/grants/index_txt_files/sites/autosome_sites

fst_folder=/home/genis/grants/analyses/new130320NoRecAdmix/fst/autosomal_global

# reference genomes, use thom for 3dsfs to fsc, cow for the rest
thom=/home/genis/grants/data/thomson_genome/thom_ref.fa.gz
cow=/home/genis/grants/data/cow_genome/bosTau8.fa

# do saf files per pop with either cow or thom as ancestral
cat $pop_inf/pops_list.txt | while read pop
do
    
    n="$(wc -l $pop_inf/bams_$pop.txt | cut -f1 -d" ")"
    half=$(($n/2))

    $angsd -bam $pop_inf/bams_$pop.txt -anc $cow -gl 2 -doSaf 1 -minMapQ 30 -minQ 20 -minInd $half -sites $sites_folder/autosome_sites_to_keep_nochr16_$pop.txt -nThreads 30 -doCounts 1 -setMaxDepth 5000 -out $saf_folder/cow/${pop}

    $angsd -bam $pop_inf/bams_$pop.txt -anc $thom -gl 2 -doSaf 1 -minMapQ 30 -minQ 20 -minInd $half -sites $sites_folder/autosome_sites_to_keep_nochr16_$pop.txt -nThreads 30 -doCounts 1 -setMaxDepth 5000 -out $saf_folder/thom/${pop}

    $realSFS $saf_folder/cow/${pop}.saf.idx -P 30 > $out_dir/sfs/${pop}_cowanc.sfs

    $realSFS $saf_folder/thom/${pop}.saf.idx -P 30 > $out_dir/sfs/${pop}_thomanc.sfs    
done



# Do 2dsfs from cow ancestral saf files, use it to estimate global fsts
cat $pop_inf/pop_pairs.info | while read pair
do
   pop1="$(echo $pair | cut -f1 -d".")"
   pop2="$(echo $pair | cut -f2 -d".")"

   $realSFS $saf_folder/cow/${pop1}.saf.idx $saf_folder/cow/${pop2}.saf.idx -P 30 > $out_dir/2dsfs/$pair.2dsfs
    
   $realSFS fst index -whichFst 1 $saf_folder/cow/${pop1}.saf.idx $saf_folder/cow/${pop2}.saf.idx -P 30 -sfs $out_dir/2dsfs/$pair.2dsfs -fstout $fst_folder/binary/$pair

   $realSFS fst stats $fst_folder/binary/$pair.fst.idx > $fst_folder/$pair.fst
    
done


# Do 3dsfs from thom ancestral saf files, which will be used for fsc parameter inference
cat $pop_inf/pop_trios.info | while read trio
do
    pop1="$(echo $trio | cut -f1 -d".")"
    pop2="$(echo $trio | cut -f2 -d".")"
    pop3="$(echo $trio | cut -f3 -d".")"
    
    $realSFS  $saf_folder/thom/${pop1}.saf.idx $saf_folder/thom/${pop2}.saf.idx $saf_folder/thom/${pop3}.saf.idx -P 30 > $out_dir/3dsfs/$trio.3dsfs

    # Do 100 bootstrap replicates

    $realSFS  $saf_folder/thom/${pop1}.saf.idx $saf_folder/thom/${pop2}.saf.idx $saf_folder/thom/${pop3}.saf.idx -bootstrap 100 -resample_chr 1 -P 30 > $out_dir/3dsfs/${trio}_boot.3dsfs 
done
