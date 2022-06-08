#!/usr/bin/perl
use strict;
use warnings;

=head1 AUTHOR 
Dr. Tim A. Dahlmann
tim.dahlmann@rub.de
Chair of General and Molecular Botany
Ruhr-University Bochum
Universitaetsstr. 150
44801 Bochum, Germany

=head2 VERSION
Verion #2 from 01.04.2018
Previous script: "collapse_reads.pl"
Version #2: Optimized usage and output.

=head3 DISCRIPTION
This perl script (tested for perl 5.26.2) reads in a multi-fasta or -fastq file and calculates the individual number of all unique reads.
It prints out the results into a tab-delimited text file. The number of identical entries for each unique read is shown within
the fasta header of each unique read, like _x12 for 12 reads. Furthermore, a prefix is added for further identification, e.g. Cn1.
To create an identifier, number from a consecutive numbering will be added between the prefix and the read count.
Thus, the output will look like this:
>Cn1_12345_x12

=head4 USAGE
perl collapse_reads.pl input.fa Cn1 output.fa 
=cut


# check if we have the correct number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 3) {
  print "\nUsage: perl collapse_reads.pl input.fa prefix output.fa\n";
  exit;
}

my $inputfile=$ARGV[0]; # <= Inputfile
my $prefix=$ARGV[1]; 	# <= Prefix
my $outputfile=$ARGV[2];# <= Outputfile
# print "Input sequence file: $inputfile, Prefix: $prefix, Output file: $outputfile\n";

open INPUT, "< $inputfile" or die {"Can't open inputfile!\n"}; # Open inputfile
open OUTPUT, "> $outputfile"; # Open outputfile

my @daten = <INPUT>;
chomp @daten;	# Get rid of all newlines
my @seq;


my $readcount=0;
my $uniquecount=0;
my $read;
my $count=0;

# just analyze the nucleotide sequences, we don't need the header or quality information from the fasta or fastq file
foreach (@daten) {
	if ($_ =~ /^([ATGCNRYSWKM]+)$/i) {	
		push (@seq, $1);
		$readcount++;
	}
}

# run through the reads and count them
my %count;
foreach $read (@seq) {
	$count{$read}++;
}

# sort the unique reads by their read count from high to low and print out the result to STDOUT and the output file
foreach $read (sort { $count{$b} <=> $count{$a} } keys %count) {
	$uniquecount++;
	print OUTPUT ">$prefix\_$uniquecount\_x$count{$read}\n$read\n";
	print ">$prefix\_$uniquecount\_x$count{$read}\n$read\n";
}

close INPUT;
close OUTPUT;
