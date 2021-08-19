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
Verion #4 from 08.10.2020
Previous script: "count-read-length.pl"
Version #2: Add arguments and argument count for optimized usage.
Version #3: Add parameters for fastq analysis and count for all sequences.
Version #4: Simplify coding to make it faster and to optimize the the data output.

=head3 DISCRIPTION
This perl script (tested for perl 5.26.2) reads in a multi-fasta or multi-fastq file and calculates the size and 
the number of sequences/reads of a specific length in total and of those starting with either U, A, G, or C.
It prints out the results on screen and into a tab-delimited text file. The number of total reads and the sum of U,A,G,C reads 
might vary because of ambiguous base calling at 5'-end (N,R,Y,S,W,K,M).

=head4 USAGE
perl count-read-length.pl input.fasta output.txt

=cut

# Identification of reads with the same size and same 5'-nucleotide



my $inputfile=$ARGV[0]; # <= Inputfile
my $outputfile=$ARGV[1]; # <= Outputfile

if ($inputfile =~ /--help/) {
	print "\nUsage: perl read-length.pl inputfile.fasta outputfile.txt\n\nThis perl script (tested for perl 5.26.2) reads in a multi-fasta or multi-fastq file (inputfile.fasta) and calculates the size and the number of sequences/reads of a specific length in total and of those starting with either U, A, G, or C.
It prints out the results on screen and into a tab-delimited text file (outputfile.txt). 
The number of total reads and the sum of U,A,G,C reads might vary from the number of total reads because of ambiguous nucleotides at the 5'-end (N,R,Y,S,W,K,M).";
	exit;
}

# check if we have the correct number of arguments
my $num_args = $#ARGV + 1;
if ($num_args != 2) {
	print "\nUsage: perl read-length.pl inputfile.fasta outputfile.txt";
	exit;
}


open INPUT, "< $inputfile" or die {"Can't open inputfile!\n"};	# Open the input file
open OUTPUT, "> $outputfile"; 									# Open the output file

my @daten;
chomp (@daten = <INPUT>);	# Get rid of all newlines

my $whole_seq =0;
my $seq_laenge;
my $seq_laengeU;
my $seq_laengeA;
my $seq_laengeG;
my $seq_laengeC;

my %hashall;
my %hashU;
my %hashA;
my %hashG;
my %hashC;

# Identify of the inputfile contains fasta or fastq sequences
if ($daten[0] =~ /^>/) {
	print "The input files contains fasta sequences!\n";
	}
if ($daten[0] =~ /^@/) {
	print "The input file contains fastq sequences!\n";	
	}

# Borders ($min and $max) of the read length that should be taken into account
my $min = 14;
my $max = 73;


for (my $i=$min; $i <= $max; $i++) {	# Create hashes filled with zeros to avoid gaps
	$hashall{"$i"} =0;					
	$hashU{"$i"} =0;
	$hashA{"$i"} =0;
	$hashG{"$i"} =0;
	$hashC{"$i"} =0;
}


foreach (@daten) {
	if ($_ =~ /^[ATGCNRYSWKM]+$/) {		# identify all sequences
		my $seq = $_;
		#$whole_seq += length($_);		# calculate the sum of all reads length in nt
		$seq_laenge = length($_);		# calculate read length
		$hashall{"$seq_laenge"} +=1;	# count reads with the same read length and write it to %hashall
	}
	if ($_ =~ /^T[ATGCNRYSWKM]+$/) {	# 5'-U (DNA: T, RNA: U)
		my $seq = $_;
		$seq_laengeU = length($_);
		$hashU{"$seq_laengeU"} +=1;
	}
	if ($_ =~ /^A[ATGCNRYSWKM]+$/) {	# 5'-A
		my $seq = $_;
		$seq_laengeA = length($_);
		$hashA{"$seq_laengeA"} +=1;
	}
	if ($_ =~ /^G[ATGCNRYSWKM]+$/) {	# 5'-G
		my $seq = $_;
		$seq_laengeG = length($_);
		$hashG{"$seq_laengeG"} +=1;
	}
	if ($_ =~ /^C[ATGCNRYSWKM]+$/) {	# 5'-C
		my $seq = $_;
		$seq_laengeC = length($_);
		$hashC{"$seq_laengeC"} +=1;
	}
}


print "size\t#reads\t5'-U\t5'-A\t5'-G\t5'-C\n";			# header for print on screen
print OUTPUT "size\t#reads\t5'-U\t5'-A\t5'-G\t5'-C\n";	# header for OUTPUT file

my $x = $min;	# counter starting with the minimal size border $min
foreach $seq_laenge (sort {$a <=> $b } keys %hashall) {		# numerical sort
	print "$seq_laenge\t$hashall{$seq_laenge}\t$hashU{$x}\t$hashA{$x}\t$hashG{$x}\t$hashC{$x}\n";			# print on screen
	print OUTPUT "$seq_laenge\t$hashall{$seq_laenge}\t$hashU{$x}\t$hashA{$x}\t$hashG{$x}\t$hashC{$x}\n";	# print in OUTPUT
	$x++;		# add +1 to the minimal border, $max will be reached automatically
}
 

close INPUT;
close OUTPUT;
