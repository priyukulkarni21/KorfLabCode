#!/usr/bin/perl
use strict; use warnings;
use FeatureComp2;

## Double array-based linear search
## Read one file into an array. Open the other file and compare each feature to the array of features.

die "usage: ./DoubleArrayBasedLS.pl <bed1> <bed2>" unless @ARGV == 2 ;

my ($inp, $inp2) = @ARGV;

my $features1 = FeatureComp2::read_bed($inp); 		# read bed files into arrays of hashes
my $features2 = FeatureComp2::read_bed($inp2);


# read bed file into array of hashes
# return a reference to the array
# so it's an array of hashes. I want to read that


for (my $i = 0; $i < @$features1; $i++){
	my $f1 = $features1->[$i];
	my $find =0;
	my $str = "";
	for (my $j = 0; $j < @$features2; $j++){
		my $f2 = $features2->[$j];
		if (FeatureComp2::overlap($f1, $f2)){  #call overlap in FeatureComp2 package. # if overlaps then push first file's feature into newarr
			$str = "$f1->{chrom}\t$f1->{beg}\t$f1->{end}";
			$find = 1;
		}
	}
	if ($find ==1){
	print $str, "\n";
	}
}


