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
Verion #1 from 08.10.2020

=head3 DISCRIPTION
Reads in several 'depth' output files from BEDtools and combines them to a output file containing the read depths of all samples for C. neoformans chr01 from position 2200000 until its end.
This was independently performed for the forward and reverse strand of C. neoformans chr01.
The output file contains the read depth for that specified region for all five samples.

=head4 USAGE
perl coverage_table.pl

=cut

# Hardcoded input and output
my $file1 = "H99_forward_depth.txt";		# <= Inputfile
my $file2 = "Bt81_forward_depth.txt";		# <= Inputfile
my $file3 = "Bt65_forward_depth.txt";		# <= Inputfile
my $file4 = "Bt65_ZNF3_T1_forward_depth.txt";	# <= Inputfile
my $file5 = "Bt65_ZNF3_T2_forward_depth.txt";	# <= Inputfile
my $outputfile = "merged_forward_table.txt";	# <= Outputfile

print ("Open inputfiles...\n");
open INPUT1, "< $file1" or die {"Can't open inputfile $file1!\n"}; # Open inputfile
open INPUT2, "< $file2" or die {"Can't open inputfile $file2!\n"}; # Open inputfile
open INPUT3, "< $file3" or die {"Can't open inputfile $file3!\n"}; # Open inputfile
open INPUT4, "< $file4" or die {"Can't open inputfile $file4!\n"}; # Open inputfile
open INPUT5, "< $file5" or die {"Can't open inputfile $file5!\n"}; # Open inputfilee
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

exit;
