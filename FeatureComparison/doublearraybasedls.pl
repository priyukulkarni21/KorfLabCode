#!/usr/bin/perl
use strict; 
use warnings;
use FeatureCompare;

## Double array-based linear search
## Read one file into an array. Open the other file and compare each feature to the array of features.

die "usage: ./doublearraybasedls.pl <bed1> <bed2>" unless @ARGV == 2 ;

my ($inp, $inp2) = @ARGV;

my $features1 = FeatureCompare::read_bed($inp); 		# call read_bed in FeatureComp2 
my $features2 = FeatureCompare::read_bed($inp2);	    	# read_bed will read the bed file into array of features (hashes)

# main code for double array based linear search: 
for (my $i = 0; $i < @$features1; $i++){
	my $f1 = $features1->[$i];
	my $found = 0;
	for (my $j = 0; $j < @$features2; $j++){
		my $f2 = $features2->[$j];
		if (FeatureCompare::overlap($f1, $f2)){  			# call overlap   
			$found = 1;					# if overlap, $found = 1
		}
	}
}
	
	if ($found == 1){
		print $f1->{chrom}, "\t", $f1->{beg}, "\t", $f1->{end}, "\n";		# print if $found = 1 
	}						
}


