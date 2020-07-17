bfile=/home/genis/grants/analyses/gl_beagle/gl_hwe_filter.beagle.gz
fqprefix=/home/genis/grants/analyses/admixture/ngsadmix/results_best_likes/ngsadmix_result_
outdir=/home/genis/grants/analyses/NGSadmix_evaluation
evalAdmix=/home/genis/admix_evaluation/implementation_c/evaluateAdmix/evalAdmix

for k in `seq 2 7`
do
    $evalAdmix -beagle $bfile -fname $fqprefix${k}*.fopt.gz -qname $fqprefix${k}*.qopt -o $outdir/grantsCorResK$k.txt -P 20 -autosomeMax 29
done
