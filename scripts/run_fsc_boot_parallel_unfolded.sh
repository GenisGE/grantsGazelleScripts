#!/bin/bash

model=$1
run_fsc=boot_inference_unfolded.sh

ulimit -m 1000000
ulimit -v 1000000
seq 100 | xargs -n1 -P20 bash $run_fsc $model
