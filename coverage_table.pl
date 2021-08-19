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
#my $num_args = $#ARGV + 1;
#if ($num_args != 2) {
#  print "\nUsage: perl read-length.pl inputfile.sam outputfile.txt";
#  exit;
#}

#my $inputfile=$ARGV[0]; # <= Inputfile
#my $outputfile=$ARGV[1]; # <= Outputfile

my $file1 = "H99_forward_depth.txt";	# <= Inputfile
my $file2 = "Bt81_forward_depth.txt";	# <= Inputfile
my $file3 = "Bt65_forward_depth.txt";	# <= Inputfile
my $file4 = "Bt65_ZNF3_T1_forward_depth.txt";	# <= Inputfile
my $file5 = "Bt65_ZNF3_T2_forward_depth.txt";	# <= Inputfile
my $outputfile = "merged_forward_table.txt";			# <= Outputfile

print ("Open inputfiles...\n");
open INPUT1, "< $file1" or die {"Can't open inputfile $file1!\n"}; # Öffnen der Inputfile
open INPUT2, "< $file2" or die {"Can't open inputfile $file2!\n"}; # Öffnen der Inputfile
open INPUT3, "< $file3" or die {"Can't open inputfile $file3!\n"}; # Öffnen der Inputfile
open INPUT4, "< $file4" or die {"Can't open inputfile $file4!\n"}; # Öffnen der Inputfile
open INPUT5, "< $file5" or die {"Can't open inputfile $file5!\n"}; # Öffnen der Inputfile
open OUTPUT, "> $outputfile"; # Öffnen der Outputfile
print ("Read in all inputfiles successfully!\n");

my $whole_seq =0;
my $seq_laenge;

my $position = 2200000;
my @out1;
while (my $elem = <INPUT1>) {
	if ($elem =~ /Bt65_Chr01\t$position\t(\d*)\n/) {
		push (@out1, "$position\t$1");
		$position ++;
	}
}
print ("File $file1 was processed successfully!\n");

$position = 2200000;
my @out2;
while (my $elem = <INPUT2>) {
	if ($elem =~ /Bt65_Chr01\t$position\t(\d*)\n/) {
		push (@out2, "$1");
		$position ++;
	}
}
print ("File $file2 was processed successfully!\n");

$position = 2200000;
my @out3;
while (my $elem = <INPUT3>) {
	if ($elem =~ /Bt65_Chr01\t$position\t(\d*)\n/) {
		push (@out3, "$1");
		$position ++;
	}
}
print ("File $file3 was processed successfully!\n");

$position = 2200000;
my @out4;
while (my $elem = <INPUT4>) {
	if ($elem =~ /Bt65_Chr01\t$position\t(\d*)\n/) {
		push (@out4, "$1");
		$position ++;
	}
}
print ("File $file4 was processed successfully!\n");

$position = 2200000;
my @out5;
while (my $elem = <INPUT5>) {
	if ($elem =~ /Bt65_Chr01\t$position\t(\d*)\n/) {
		push (@out5, "$1");
		$position ++;
	}
}
print ("File $file5 was processed successfully!\n");

print ("Merging the files...\n");
my @merged;
	push(@merged, "Chr1_forward_pos\tH99\tBt81\tBt65\tBt65_ZNF3_T1\tBt65_ZNF3_T2\n"); 

foreach (@out1) {
	my $a = shift(@out1);
	my $b = shift(@out2);
	my $c = shift(@out3);
	my $d = shift(@out4);
	my $e = shift(@out5);
	push(@merged, "$a\t$b\t$c\t$d\t$e\n"); 
}

print ("All files were merged sucessfully!\n");
#print @merged;
print OUTPUT @merged;


close INPUT1;
close INPUT2;
close INPUT3;
close INPUT4;
close INPUT5;
close OUTPUT;
