#!/bin/sh

# ascertain in all
#input_file=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/treemixformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx.frq.strat.input_treemix.gz
#out_dir=/home/genis/grants/analyses/new130320NoRecAdmix/treemix/ascertainsnpsALLpops/results

#ascertain in granti
input_file=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/treemixformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx_grantisnps.frq.strat.input_treemix.gz
out_dir=/home/genis/grants/analyses/new130320NoRecAdmix/treemix/ascertainsnpsGRANTIpops/results


for m in `seq 0 5`; do
    mkdir ${out_dir}/m${m}
    rm $out_dir/m${m}_all.likes
	for seed in `seq 1 100`; do
	    treemix -i $input_file -o $out_dir/m${m}/grants_treemix_m${m}_${seed} -m $m -root thomson -n_warn 0 -k 50 -seed $seed | tee $out_dir/m${m}/grants_treemix_m${m}_${seed}.log
	    tail -1 $out_dir/m${m}/grants_treemix_m${m}_${seed}.llik | cut -f2 -d":" >> $out_dir/m${m}_all.likes
	done
done


# do bootstrap in 
for i in `seq 1 100`; do
    treemix -i $input_file -o $out_dir/grants_treemix_m2_boot_${i} -m 2 -root thomson -n_warn 0 -k 50 -bootstrap | tee $out_dir/grants_treemix_m2_boot_${i}.log
    zcat $out_dir/grants_treemix_m2_boot_${i}.treeout.gz | head -1 >> $out_dir/all_treemix_boot_m2.trees
done
