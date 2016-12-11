#!/usr/bin/perl
use strict; use warnings;
use FeatureComp2;
use List::MoreUtils qw/ uniq /;

## Double array-based linear search
## Read one file into an array. Open the other file and compare each feature to the array of features.

die "usage: ./DoubleArrayBasedLS.pl <bed1> <bed2>" unless @ARGV ==2 ;

my ($inp, $inp2) = @ARGV;

my @arr1 = @{FeatureComp2::read_bed($inp)}; 		# read bed files into arrays of hashes
my @arr2 = @{FeatureComp2::read_bed($inp2)};

# so it's an array of hashes. I want to read that
my $find = 0;
my @newarr;

for (my $i = 0; $i < scalar(@arr1); $i++){
	for (my $j = 0; $j < scalar(@arr2); $j++){
		my $find = FeatureComp2::overlap(\%{$arr1[$i]}, \%{$arr2[$j]});  #call overlap in FeatureComp2 package
		if ($find == 1){		# if overlaps then push first file's feature into newarr
			my $str = "$arr1[$i]->{chrom}\t$arr1[$i]->{beg}\t$arr1[$i]->{end}";
			push @newarr, $str;
			$find = 0;
		}
	}
}

## print unique arr 
$"  = "\n";
my @unarr = uniq(@newarr);
print "@unarr\n";



