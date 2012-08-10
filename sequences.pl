#!/usr/bin/perl -w
# Author and script information

use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;
use Bio::Structure::SecStr::DSSP::Res;

# Getting external parameters
my $protein_name = $ARGV[0];

# DSSP processor
#  GETTING DSSP INFORMATION
#  This part of the script uses the previously called library (Bioperl)
#  The argument "'-fh'=>\*STDIN" instead a file name is to read the
#  text from the standar input. So, it is necesary to put the dssp data
#  in the console and not in a file.
my $dssp = new Bio::Structure::SecStr::DSSP::Res('-file' => "dssp_temp" );

#  Store the whole information about each residue
my @residues = $dssp->residues();

# Print the fasta item head
print ">$protein_name\n";

# Print the sequence from the coordinates file
for my $resID (@residues){
        
    # Print one residue
    my $res = $dssp->resAA($resID);
    # Sometimes, Cys resisues are designated wiht the characters 'a' or 'b'
    # when they are involved in disulfure bridges
    if ($res eq 'a' or $res eq 'b'){ $res = 'C'; }
    
    print $res;
    
}

print "\n";