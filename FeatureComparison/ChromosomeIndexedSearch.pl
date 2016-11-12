#!/usr/bin/perl
use strict; use warnings;

# Chr indexed linear search
# Read both files into hashes where the hash key is the chromosome and the value is a reference to an array of features. Compare all features on the same chromosomes.

## What I will be doing is opening up the files and making them into hash so that I can compare them. 

## Does the feature in file1 overlap with any in file2? If so, print it

die "usage: FileBasedLinearSearch.pl <bed1> <bed2>" unless @ARGV == 2;

my ($b1, $b2) = @ARGV;

# put phonebook into hash


my %bed1 = read_bed($b1);
my %bed2 = read_bed($b2);


sub read_bed{
	my ($file) = @_;
	open(my $in, "<", $file) or die;

	my %bed;	
	while (<$in>){
		chomp;
		my ($chr, $beg, $end) = split("\t", $_);
		push (@{$bed{$chr}}, {beg => $beg, end => $end}); # The hash key is the chr, each of which has an array that holds a hash for beg, end

	}
	close $in;
	return %bed;
}



# to access them all and print each line: 
foreach my $chr (keys %bed1){ 
	foreach my $line (@{$bed1{$chr}}){
		print ($chr, "\t", $line->{beg}, "\t" ,$line->{end}, "\n");
	}
}


