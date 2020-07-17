#!/bin/bash

# NEED to have folder created with input files in it
# $1 is model, $2 is n run

fsc=/home/genis/software/fsc26_linux64/fsc26
folder=/home/genis/grants/analyses/new130320NoRecAdmix/fastsimcoal/$1

cd $folder

rm -r $1_$2
mkdir $1_$2
cp $1.est ./$1_$2/
cp $1.tpl ./$1_$2/
cp $1*.obs ./$1_$2/
cd $1_$2


#-u if multisfs format
$fsc -t $1.tpl -e $1.est -M -d -L 40 -n 200000 --seed $2 -C20 -u -c2 -B2
#$fsc -t $1.tpl -e $1.est -M -d -L 40 -n 100000 --seed $2 -C20 -c2 -B2
