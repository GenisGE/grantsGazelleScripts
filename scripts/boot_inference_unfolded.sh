 #!/bin/bash

#Need to have input files in /home/genis/grants/analyses/fastsimcoal/${1}/${prefix}
# $1 is model and $2 is n bootstrap

fsc=/home/genis/software/fsc26_linux64/fsc26
prefix=${1}_boot
folder=/home/genis/grants/analyses/new130320NoRecAdmix/fastsimcoal/${1}/${prefix}/${prefix}


cd ${folder}/${prefix}_${2}
cp ../../${prefix}.tpl .
cp ../../${prefix}.est .
cp ../../${prefix}.pv .

$fsc -t ${prefix}.tpl -e ${prefix}.est -n100000 -d -M -L40 --initvalues ${prefix}.pv -C20 -u -c2 -B2
