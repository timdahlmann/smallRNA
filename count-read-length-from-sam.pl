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

my @daten;
chomp (@daten = <INPUT>);	# Entfernen aller newlines

my $whole_seq =0;
my $seq_laenge;
my %hashall;


for (my $i=14; $i <= 73; $i++) {	# $max is the afore calculated maximal clonality
		$hashall{"$i"} =0;			# Create a %hash filled with zeros
}



foreach (@daten) {
	if ($_ =~ /0\t([ATGCNRYSWKM]+)\t/) {	# Identifiziert die Identifier
		my $seq = $1;
		$whole_seq += length($1);
		$seq_laenge = length($1);	# Bestimmung der Sequenzlängen aller Sequenzen
		$hashall{"$seq_laenge"} +=1;	# Schreiben der Anzahl der Sequenzlängen in %hash
	}
}

print "The size of all sequnces amounts to $whole_seq nt!\n";

#print %hash;

foreach $seq_laenge (sort {$a <=> $b } keys %hashall) {	# Numerisch aufsteigend sortieren
	print "$seq_laenge\t$hashall{$seq_laenge}\n";		# Ausgabe auf dem Monitor
	print OUTPUT "$seq_laenge\t$hashall{$seq_laenge}\n";
}
	
#foreach $seq_laenge (sort {$a <=> $b } keys %hashall) {	# Numerisch aufsteigend sortieren
#	print OUTPUT "$seq_laenge\t$hashall{$seq_laenge}\n";	# Ausgabe in OUTPUT
#}

### Loop for 5'-U
print "\nStarting with U\n";
print OUTPUT "\nStarting with U\n";

my $seq_laengeU;
my %hashU;

for (my $i=14; $i <= 73; $i++) {	# $max is the afore calculated maximal clonality
		$hashU{"$i"} =0;			# Create a %hash filled with zeros
}

foreach (@daten) {
	if ($_ =~ /0\t(T[ATGCNRYSWKM]+)\t/) {	# Identifiziert die Identifier
		my $seq = $1;
		$seq_laengeU = length($1);	# Bestimmung der Sequenzlängen aller Sequenzen
		$hashU{"$seq_laengeU"} +=1;	# Schreiben der Anzahl der Sequenzlängen in %hash
	}
}

foreach $seq_laengeU (sort {$a <=> $b } keys %hashU) {	# Numerisch aufsteigend sortieren
	print "$seq_laengeU\t$hashU{$seq_laengeU}\n";
	print OUTPUT "$seq_laengeU\t$hashU{$seq_laengeU}\n";	# Ausgabe auf dem Monitor
}

### Loop for 5'-A
print "\nStarting with A\n";
print OUTPUT "\nStarting with A\n";

my $seq_laengeA;
my %hashA;

for (my $i=14; $i <= 73; $i++) {	# $max is the afore calculated maximal clonality
		$hashA{"$i"} =0;			# Create a %hash filled with zeros
}

foreach (@daten) {
	if ($_ =~ /0\t(A[ATGCNRYSWKM]+)\t/) {	# Identifiziert die Identifier
		my $seq = $1;
		$seq_laengeA = length($1);	# Bestimmung der Sequenzlängen aller Sequenzen
		$hashA{"$seq_laengeA"} +=1;	# Schreiben der Anzahl der Sequenzlängen in %hash
	}
}

foreach $seq_laengeA (sort {$a <=> $b } keys %hashA) {	# Numerisch aufsteigend sortieren
	print "$seq_laengeA\t$hashA{$seq_laengeA}\n";
	print OUTPUT "$seq_laengeA\t$hashA{$seq_laengeA}\n";	# Ausgabe auf dem Monitor
}

### Loop for 5'-G
print "\nStarting with G\n";
print OUTPUT "\nStarting with G\n";

my $seq_laengeG;
my %hashG;

for (my $i=14; $i <= 73; $i++) {	# $max is the afore calculated maximal clonality
		$hashG{"$i"} =0;			# Create a %hash filled with zeros
}

foreach (@daten) {
	if ($_ =~ /0\t(G[ATGCNRYSWKM]+)\t/) {	# Identifiziert die Identifier
		my $seq = $1;
		$seq_laengeG = length($1);	# Bestimmung der Sequenzlängen aller Sequenzen
		$hashG{"$seq_laengeG"} +=1;	# Schreiben der Anzahl der Sequenzlängen in %hash
	}
}

foreach $seq_laengeG (sort {$a <=> $b } keys %hashG) {	# Numerisch aufsteigend sortieren
	print "$seq_laengeG\t$hashG{$seq_laengeG}\n";
	print OUTPUT "$seq_laengeG\t$hashG{$seq_laengeG}\n";	# Ausgabe auf dem Monitor
}

### Loop for 5'-C
print "\nStarting with C\n";
print OUTPUT "\nStarting with C\n";

my $seq_laengeC;
my %hashC;

for (my $i=14; $i <= 73; $i++) {	# $max is the afore calculated maximal clonality
		$hashC{"$i"} =0;			# Create a %hash filled with zeros
}

foreach (@daten) {
	if ($_ =~ /0\t(C[ATGCNRYSWKM]+)\t/) {	# Identifiziert die Identifier
		my $seq = $1;
		$seq_laengeC = length($1);	# Bestimmung der Sequenzlängen aller Sequenzen
		$hashC{"$seq_laengeC"} +=1;	# Schreiben der Anzahl der Sequenzlängen in %hash
	}
}

foreach $seq_laengeC (sort {$a <=> $b } keys %hashC) {	# Numerisch aufsteigend sortieren
	print "$seq_laengeC\t$hashC{$seq_laengeC}\n";
	print OUTPUT "$seq_laengeC\t$hashC{$seq_laengeC}\n";	# Ausgabe auf dem Monitor
}

#while (($key, $wert) = each %hash) {
#	print "Der Wert von $key ist $wert.\n";
#}

close INPUT;
close OUTPUT;
