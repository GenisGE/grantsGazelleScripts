model=$1
qpgraph=/home/genis/software/AdmixTools/src/qpGraph
par=/home/genis/grants/scripts/scripts130320NoRecAdmix/parQPgraph
graph=/home/genis/grants/analyses/new130320NoRecAdmix/qpgraph/input_graphs/$model.graph
out=/home/genis/grants/analyses/new130320NoRecAdmix/qpgraph/output/$model

$qpgraph -p $par -g $graph -o $out.ggg -d $out.dot > $out.out
