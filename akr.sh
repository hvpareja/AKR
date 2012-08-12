inputpdbfile=$1
n=$2
./dssp $inputpdbfile dssp_temp 2> /dev/null
./sequences.pl prot_$n > temp_seq 2> /dev/null
grep "^[^>]" temp_seq | ./surface.pl > temp_surf prot_$n 2> /dev/null

cat temp_seq temp_surf

rm dssp_temp
rm temp_seq
rm temp_surf

