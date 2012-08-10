inputpdbfile=$1
./dssp $inputpdbfile dssp_temp
./sequences.pl
rm dssp_temp
