#!/usr/bin/perl
use strict;
use warnings;

=head1 AUTHOR 
Tim A. Dahlmann
tim.dahlmann@rub.de
Chair of general and molecular botany
Ruhr-university Bochum
44801 Bochum, Germany

=head2 VERSION
Verion #3 from 08.10.2013
Previous script: "extract-alignments-from-sam.pl"

=head3 DISCRIPTION
Reads in a .sam alignment file from SAMtools and prints out a fasta file with all aligned sequences.
=head4 USAGE
perl extract-alignments-from-sam.pl input.sam output.fa

=cut

# Bestimmung der Anzahl an Reads mit gleicher Readlaenge und Ausgabe

# check if we have the correct number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 2) {
  print "\nUsage: perl extract-alignments-from-sam.pl inputfile.sam outputfile.txt";
  exit;
}

my $inputfile=$ARGV[0]; # <= Input file
my $outputfile=$ARGV[1]; # <= Output file

open INPUT, "< $inputfile" or die {"Can't open inputfile!\n"}; # Öffnen der Inputfile
open OUTPUT, "> $outputfile"; # Open Output file

my @out;
my $counter = 0;

while (<INPUT>) {
	if (($_ =~ /^[0-9A-Z_a-z]/) and ($_ =~ /0\t([ATGCNRYSWKM]+)\t/)) {	# Get the identifier
		$counter ++;
		my $seq = $1;
		push (@out, ">read_$counter\n$seq\n");
	}
}

#print @out;

print OUTPUT @out; # print it into the output file

close OUTPUT;
close INPUT;

exit;
