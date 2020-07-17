#!/bin/bash

Nruns=$1
model=$2
run_fsc=demo_inf_fastsimcoal_unfoldedSFS_norecadmx.sh

ulimit -m 1000000
ulimit -v 1000000
seq $Nruns | xargs -n1 -P20 bash $run_fsc $model
