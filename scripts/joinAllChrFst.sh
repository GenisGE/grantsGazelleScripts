infolder=/home/genis/grants/analyses/new130320NoRecAdmix/fst/byChrOnlyMales/fst
outfile=/home/genis/grants/analyses/new130320NoRecAdmix/fst/byChrOnlyMales/allFstByChrOnlyMales2.txt

rm $outfile

for i in `seq 1 29` X; do

    ls $infolder | grep -F "chr$i.fst2" | while read file; do
	fst="$(tail -1 $infolder/$file | cut -f2)"
	echo "$file $fst" >> tmp
	done


done

sed -i "s/_chr/ chr/g" tmp
sed -i "s/.fst2//g" tmp

echo "Populations Chromosomes Fst" > tmp_header
cat tmp_header tmp > $outfile

rm tmp_header
rm tmp
