# Scripts used on the analysis of RAD-sequence data of Grant's gazelle

These are the scripts used to perform the analyses in the paper "Vicariance followed by secondary gene flow in a young gazelle species complex" 

I provide the scripts as they are, if you want to use them you will have to change paths and probably fix issues. 

Contact: Genis Garcia Erill genis.erill@bio.ku.dk

## Software needed

```
SAMTOOLS
ANGSD
PLINK v 1.9
PCANGSD v0.973
NGSADMIX
EVALADMIX
TREEMIX
QPGRAPH
FASTSIMCOAL2
NGSRELATE2
```

## Info files:

```
infoFiles/bams_over_50bp_with_outgroup.txt: list of all bam files used.
infoFiles/pop_info_with_outgroup.txt: individual ID, sampling locality and assigned population corresponding to each sample in bams_over_50bp_with_outgroup.txt
infoFiles/bams_over_50bp_final_filters_subset1.txt: list of Grant's gazelle bam files after individual quality control filters.
infoFiles/pop_info_final_filters_subset1.txt: individual ID, sampling locality and assigned population corresponding to each sample in bams_over_50bp_final_filters_subset1.
infoFiles/blacklist_hwe_e3.txt: sites to be excluded from all analyses based on HWE equilibrium test.
```

# Steps

### 1. HWE test (ANGSD + PCANGSD)


```
# First do genotype likelihood file that will be used as input for pcangsd with
scripts/do_beagle_for_hwe_test.sh
# This will generate output.beagle.gz file that can be used as input for pcangsd to do HWE test in the following script
scripts/do_hwe_filter_pcangsd.sh
# This generates out.lrt and out.sites files. Identify those sites where lrt > 24 and exclude them from all subsequent analyses
```


### 2. Estimate relatedness with a. ngsRelatev2 b. allele frequency method (angsd+realSFS+Rscript)

```
# a. Run ngsRelate
scripts/run_ngsRelate.sh

# b. Allele frequency free method. Frist estimate 2DSFS between pairs we want to estiamte relatednes
scripts/do_relatedness_ratios.sh
# b. Use Rscript to calculate relatedness ratios from individuals 2dsfs. 
Rscript scripts/calc_ratios.R indsIDs
```


### 3. Population structure: PCAngsd, NGSadmix and evalAdmix

```
# 1. Make genotype beagle file with hwe filter to use in following analyses
scripts/do_beagle_to_use.sh

# 2. Perform PCA with PCAngsd
scripts/do_pca_pcangsd.sh

# 3. Run NGSAdmix
scripts/do_ngsadmix.sh K # K is the number of ancestral populations you want to assume. We did from 2 to 9, only 2 to 7 converged

# 4. Run evalAdmix (you need first to select best likelihood ngsadmix results for each K to use as input)
scripts/evalNGSadmixGrants.sh
```

### 4. Infer population 2DSFS and 3DSFS, and estimate global Fst from 2DSFS
```
# 4a. Do consensus fasta file from thomsons gazelle to use for polarizying 3DSFs
scripts/do_fasta_thomson.sh
# 4b. Estimate 2DSFS and global Fst between all pop pairs, estimate two 3DSFS for demographic inference
scripts/do_sfss.sh

```

### 5. Estimate heterozygosities

```
#5a. Generate individual SFS for all inds
scripts/do_heterozygosities.sh
#5b. Use individual SFS to esitmate heterozygosity ( uses Rscript in scripts/calc_h.R) 
scripts/extract_heterozygosity.sh
```

### 6. Estimate Fst per chromosome

```
# Estimate dephts in chromosome 1 and X, to infer sex of each individual
scripts/do_depths_checkSex.sh
# Estimate per chromosome Fst using only males (to avoid ploidy issues in X chromomosme)
scripts/doFstByChrOnlyMalesNoRecAdmx.sh
# Combine all estiamtedscripts/do_fasta_thomson.sh Fst in single file
scripts/joinAllChrFst.sh
# Do global Fst using only males
scripts/doFstAutosomeOnlyMales.sh
```

### 7. Call genotypes
```
scripts/call_genotypes.sh
# ... Do many filtering steps with plink to generate desired substes of files and individuals in .bed format...

# convert to input format for treemix and qpgrpah
# treemix (calls scripts/FreqsToTreemixCounts.R)
scripts/plink_to_treemix.sh 
# qpgraph (eigenstrat format, calls scripts/par.PED.EIGENSTRAT)
scripts/plinkToEigenstrat.sh
```

### 8. Run treemix

```
scripts/run_treemix.sh
```


### 9. Run qpgraph

```
# calls scripts/parQPgraph and model.graph. Models used in scripts/qpgraphmodels
scripts/runqpGraph.sh model 

```


### 10. Run fastsimcoal

```
# Using as input 3DSFS estimated with scritp do_sfss.sh, perform demographing inference (do 50 optimization runs in e.g. model1.
# Calls script demo_inf_fastsimcoal_unfoldedSFS_norecadmx.sh.
# Expects input folder called model1 exists and contains all fsc input model1.est .tpl and 3Dsfs called model1_DSFS.obs
scripts/run_fsc_paralle.sh 50 model1

# Run boostrap. expects bootstrapls folder alreayd created with initial values from maximum likelihood estiamte model.pv and each boostraped sfs
# Calls scripts boot_inference_unfolded.sh
scripts/run_fsc_boot_parallel_unfolded.sh model1

```


### 11. Dstats

```
# R functions used in
scripts/DstatsFuns.R

```
