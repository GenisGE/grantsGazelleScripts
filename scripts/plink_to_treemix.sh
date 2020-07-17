plIn=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/plinkformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx_grantisnps
plOut=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/treemixformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx_grantisnps

plink --bfile $plIn --freq counts --chr-set 29 --family --missing --out $plOut

Rscript scripts/FreqsToTreemixCounts.R $plOut.frq.strat

gzip $plOut.frq.strat.input_treemix


