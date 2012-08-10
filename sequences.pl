# Author information

use warnings;
use Bio::Structure::Model;
use Bio::Structure::IO::pdb;
use Bio::Structure::SecStr::DSSP::Res;

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

# DSSP processor
#  GETTING DSSP INFORMATION
#  This part of the script uses the previously called library (Bioperl)
#  The argument "'-fh'=>\*STDIN" instead a file name is to read the
#  text from the standar input. So, it is necesary to put the dssp data
#  in the console and not in a file.
my $dssp = new Bio::Structure::SecStr::DSSP::Res('-file' => "dssp_temp" );

#  Store the whole information about each residue
my @residues = $dssp->residues();