#!/usr/bin/perl
use strict;
use warnings;

=head1 AUTHOR 
Tim A. Dahlmann
tim.dahlmann@rub.de
Chair of general and molecular botany
Ruhr-university Bochum
44801 Bochum, Germany

=head2 DISCRIPTION
Analysis of read count of a sam file within a soecified sliding winding (e.g. 1000 bp).
A sliding window counts all reads that have a start position within the specified sliding-window. The output is printed out as a .txt file.

=head3 USAGE
perl sliding-window-read-counts-from-sam.pl input.sam window_size

=head3 VERSION
version 1.0
17.10.2013

=cut


my $num_args = $#ARGV + 1; # counter starts at zero, so we need to add one to it
if ($num_args != 2) {	# three arguments: 1. input sam file 2. non-overlapping window-steps 
  print "\nUsage: sliding-window-read-counts-from-sam.pl input.sam window_size";
  exit;
}
my $input=$ARGV[0];	# inputfile
my $steps=$ARGV[1];	# window-steps
my $window1= $ARGV[2]; # start position

open (INPUT, "<$input") or die ("Can't open input file!");

# columns of the vcf file format which was produced with samtools
#my $id = 0;	# contig_ID
my $position = 3;

my $counter1 = 0; # counter which starts with zero

	# first window starts at zero, so first nucleotid is included
my $window2 = ($window1+$steps); # steps is for the window step which is given in ARGV[1]

#counting the reads
my $readcount = 0;

#my %hashchr1;	# hash for the sliding window results
#$hashchr1{"$window2"} = 0;

my @qualityscores;	# quality scores of all SNPs which passes the tests (e.g. minquality>=50 and AF1=1)
my @allqualitys;	# quality scores of all SNPs inside the vcf
my @results;
push (@results, "window\tread_count\n");

##### Main Algorithm #####

while (my $input = <INPUT>) {
	if ($input =~ /^[A-Z]/i){	# exclude the vcf header which starts with #
		chomp $input;
		my @cells = split /\t/, $input;	# split the vcf rows into columns
			#push (@allqualitys, $cells[$quality]);	# array for statistics of all SNP quality scores
			#if (($cells[$quality] >= $minqual) and ($cells[$info] =~ /AF1=$minAF;/)) {	# check if it is a well called SNP
			#	$counter1 += 1;	# count all good SNPs
			#	push (@qualityscores, $cells[$quality]);	# array for statistics of quality scores of all passed SNPs
				Loop:
				if ($window1 < $cells[$position] and $cells[$position] <= $window2) { # if the contig fits and the quality and allele frequency is good enough count it
					$readcount += 1;

					#$hashchr1{"$window2"} +=1;
					# print "a: $window1, $window2, $cells[$position], $hashchr1{\"$window2\"}\n"; # test print
				}
				if ($cells[$position] > $window2) { # if the SNP is not located inside the window, use next window
					$window1 += $steps;
					$window2 += $steps;
					push (@results, "$window1\t$readcount\n");
					$readcount = 0;
					goto Loop;
					# print "b: $window1, $window2, $cells[$position], $hashchr1{\"$window2\"}\n"; # test print
				}
			
	}
}


##### Data Output #####

my $newfile = "Read_counts_in_$steps\_bp_windows.txt"; # open local file to save results
open OUTPUT,">$newfile";
print OUTPUT @results;


close OUTPUT;
close INPUT;

exit;