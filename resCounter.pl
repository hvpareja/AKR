#!/usr/bin/perl -w
# Author and script information

# The sequence
my $seq = <STDIN>;

# All residues
my @aminoacid_collection = ("A","C","D","E","F","G","H","I","K","L",
                            "M","N","P","Q","R","S","T","V","W","Y" );

# Counting
for my $aa (@aminoacid_collection){
    
    #print $aa." ";
    my $count = $seq =~ s/$aa//g;
    print $count."\n";
    
}