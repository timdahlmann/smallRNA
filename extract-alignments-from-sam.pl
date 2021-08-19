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
Previous script: "count-read-length.pl"
Verion #2: Add arguments and argument count for optimized usage.
Version #3: Add parameters for fastq analysis and count for all sequences.

=head3 DISCRIPTION
Reads a multi-fasta file and calculates the size and the number of nucleotide or amino acid sequences with this size and prints out a tab delimited file.
The output-file contains the calculation in this type: "seqlength" \t "seqnumber"

=head4 USAGE
perl count-read-length.pl input.fasta output.txt

=cut

# Bestimmung der Anzahl an Reads mit gleicher Readlaenge und Ausgabe

# check if we have the correct number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 2) {
  print "\nUsage: perl read-length.pl inputfile.sam outputfile.txt";
  exit;
}

my $inputfile=$ARGV[0]; # <= Inputfile
my $outputfile=$ARGV[1]; # <= Outputfile

# my $inputfile = "NG-6795_Sample_2_cutadapt_only-with-a+g-trimmed_mapped.fa";	# <= Inputfile
# my $outputfile = "NG-6795_Sample_2_cutadapt_only-with-a+g-trimmed_mapped.txt";			# <= Outputfile

open INPUT, "< $inputfile" or die {"Can't open inputfile!\n"}; # Öffnen der Inputfile
open OUTPUT, "> $outputfile"; # Öffnen der Outputfile

#my @daten = <INPUT>;
#chomp (@daten = <INPUT>);	# Entfernen aller newlines

my @out;
my $counter = 0;

while (<INPUT>) {
	if (($_ =~ /^[0-9A-Z_a-z]/) and ($_ =~ /0\t([ATGCNRYSWKM]+)\t/)) {	# Identifiziert die Identifier
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
