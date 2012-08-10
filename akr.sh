inputpdbfile=$1
n=$2
./dssp $inputpdbfile dssp_temp 2> /dev/null
./sequences.pl prot_$n > temp_seq 2> /dev/null
grep "^[^>]" temp_seq | ./resCounter.pl > temp_countRes

rm temp_countRes
rm dssp_temp
rm temp_seq