convertf=/home/genis/software/EIG-7.2.1/src/convertf
inbed=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/plinkformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx_nothomson

cp $inbed.bim $inbed.pedsnp
cp $inbed.fam $inbed.pedind

par=scripts/par.PED.EIGENSTRAT

$convertf -p $par



# THEN NEED TO FIX .ind FILE bc convertf does it wrong
indfile=/home/genis/grants/analyses/genotype_calling/cleanGenoData16032020/eigenstratformat/genos_final_inds_filts_with_outgroup_test1_minInd52_nochrUn_hwefilt_maf001_nopopmiss_nochr16X_norecadmx_nothomson.ind

cut -f2 -d":" $indfile | cut -f1 -d" "  >tmpinds
cut -f2 -d":" $indfile | cut -f2 -d" " | cut -f1 > ustmp
cut -f1 -d":" $indfile | sed -e 's/^[ \t]*//' > tmppops

paste tmpinds ustmp tmppops > $indfile

rm tmpinds
rm ustmp
rm tmppops
