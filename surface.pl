#!/usr/bin/perl -w
# Author and script information

use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;
use Bio::Structure::SecStr::DSSP::Res;

# Getting external parameters
my $protein_name = $ARGV[0];

# The sequence
my $seq = <STDIN>;

# All residues
my @aminoacid_collection = ("A","C","D","E","F","G","H","I","K","L",
                            "M","N","P","Q","R","S","T","V","W","Y" );


# ASA calculated for residue X in a GXG tripeptide with the main chain in an
# extended conformation. This hash information is necessary to calculate
# the relative exposition of each type of residue.
my %ASA_GXG_total =  (
   'A' => 113,
   'R' => 241,
   'N' => 158,
   'D' => 151,
   'C' => 140,
   'Q' => 189,
   'E' => 183,
   'G' => 85,
   'H' => 194,
   'I' => 182,
   'L' => 180,
   'K' => 211,
   'M' => 204,
   'F' => 218,
   'P' => 143,
   'S' => 122,
   'T' => 146,
   'W' => 259,
   'Y' => 229,
   'V' => 160,
# X: ambigueties
   'X' => 90
 );

# ---------------
# Counting
# ---------------
my @asa_per_res = ();
my @number_per_res = ();
my $seq2 = $seq;
my %number_per_res = (
   'A' => 0,
   'C' => 0,
   'D' => 0,
   'E' => 0,
   'F' => 0,
   'G' => 0,
   'H' => 0,
   'I' => 0,
   'K' => 0,
   'L' => 0,
   'M' => 0,
   'N' => 0,
   'P' => 0,
   'Q' => 0,
   'R' => 0,
   'S' => 0,
   'T' => 0,
   'V' => 0,
   'W' => 0,
   'Y' => 0,
# X: ambigueties
   'X' => 0
 );
for my $aa (@aminoacid_collection){
    
    #print $aa." ";
    my $count = $seq2 =~ s/$aa//g;
    $number_per_res{$aa} = $count;
    my $asa_res = $ASA_GXG_total{$aa};
    my $asa_total_res = $count*$asa_res;
    push(@asa_per_res,$asa_total_res);
    
}

# ---------------
# Total surface
# ---------------
my $total_surface = 0;
for(my $i=0;$i<length($seq);$i++){
    
    my $aminoacid = substr($seq,$i,1);
    my $one_surface = $ASA_GXG_total{$aminoacid};
    $total_surface = $total_surface + $one_surface;
    
}

#print "Total Surface:\n";
#print $total_surface."\n";

# ---------------
# Folded surface
# ---------------
# DSSP processor
#  GETTING DSSP INFORMATION
#  This part of the script uses the previously called library (Bioperl)
#  The argument "'-fh'=>\*STDIN" instead a file name is to read the
#  text from the standar input. So, it is necesary to put the dssp data
#  in the console and not in a file.
my $dssp = new Bio::Structure::SecStr::DSSP::Res('-file' => "dssp_temp" );

#  Store the whole information about each residue
my @residues = $dssp->residues();

my $folded_surface = 0;
my %asa_res_total = (
   'A' => 0,
   'C' => 0,
   'D' => 0,
   'E' => 0,
   'F' => 0,
   'G' => 0,
   'H' => 0,
   'I' => 0,
   'K' => 0,
   'L' => 0,
   'M' => 0,
   'N' => 0,
   'P' => 0,
   'Q' => 0,
   'R' => 0,
   'S' => 0,
   'T' => 0,
   'V' => 0,
   'W' => 0,
   'Y' => 0,
# X: ambigueties
   'X' => 0
 );
my %asa_res_rel = (
   'A' => 0,
   'C' => 0,
   'D' => 0,
   'E' => 0,
   'F' => 0,
   'G' => 0,
   'H' => 0,
   'I' => 0,
   'K' => 0,
   'L' => 0,
   'M' => 0,
   'N' => 0,
   'P' => 0,
   'Q' => 0,
   'R' => 0,
   'S' => 0,
   'T' => 0,
   'V' => 0,
   'W' => 0,
   'Y' => 0,
# X: ambigueties
   'X' => 0
 );

foreach my $residueID (@residues) {
    
    my $residue_type = $dssp->resAA($residueID);
    my $one_surface_folded = $dssp->resSolvAcc($residueID);
    $folded_surface = $folded_surface + $one_surface_folded;
    $asa_res_total{$residue_type} = $asa_res_total{$residue_type}+$one_surface_folded;
    
}

for my $key (keys(%asa_res_total)){
    
    $asa_res_rel{$key} = $asa_res_total{$key}*100/$folded_surface;
    
}

# ---------------
# Denature surface res
# ---------------
my %denature_surface_res = (
   'A' => 0,
   'C' => 0,
   'D' => 0,
   'E' => 0,
   'F' => 0,
   'G' => 0,
   'H' => 0,
   'I' => 0,
   'K' => 0,
   'L' => 0,
   'M' => 0,
   'N' => 0,
   'P' => 0,
   'Q' => 0,
   'R' => 0,
   'S' => 0,
   'T' => 0,
   'V' => 0,
   'W' => 0,
   'Y' => 0,
# X: ambigueties
   'X' => 0
 );
for my $key (keys(%denature_surface_res)){
    
    $denature_surface_res{$key} = $number_per_res{$key}*$ASA_GXG_total{$key};
    
}

# ---------------
# Exposition degree
# ---------------
my %exp_res = (
   'A' => 0,
   'C' => 0,
   'D' => 0,
   'E' => 0,
   'F' => 0,
   'G' => 0,
   'H' => 0,
   'I' => 0,
   'K' => 0,
   'L' => 0,
   'M' => 0,
   'N' => 0,
   'P' => 0,
   'Q' => 0,
   'R' => 0,
   'S' => 0,
   'T' => 0,
   'V' => 0,
   'W' => 0,
   'Y' => 0,
# X: ambigueties
   #'X' => 0
 );

my $sum_exp_res = 0;
for my $key (keys(%exp_res)){
    
    $exp_res{$key} = $asa_res_total{$key}*100/$denature_surface_res{$key};
    $sum_exp_res = $sum_exp_res + $exp_res{$key};
    
}

#print "Folded Surface:\n";
#print $folded_surface."\n";

# ---------------
# Compact degree
# ---------------

my $compact_degree = (1-($folded_surface/$total_surface))*100;

#print "Compact degree:\n";
printf("\n@%s\t%d\t%d\t%.2f\n",$protein_name,$total_surface,$folded_surface,$compact_degree);

printf("\n\t\t\t%s\n",$protein_name);
printf("\t--------------------------------------\n");
print("Res.\t#\tASA\t%Tsur.\tdASA\tExD\n");
printf("==============================================\n");
for my $aa (@aminoacid_collection){
    
    printf("_%s  |\t%i\t%i\t%.2f\t%i\t%.2f\n", $aa,$number_per_res{$aa},$asa_res_total{$aa},$asa_res_rel{$aa},$denature_surface_res{$aa},$exp_res{$aa});
    
}

printf("----------------------------------------------\n");
printf("Sum.|\t%i\t%i\t100\t%i\t%.2f\n",length($seq),$folded_surface,$total_surface,$sum_exp_res);
printf("==============================================\n");


print "\n";
