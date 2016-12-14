#!/usr/bin/perl
use strict;
use warnings;
use FeatureComp2;

## Sorted list binary search
## Read a list of features into an array and sort it. Use a binary search to compare features.


die "usage: $0 <bed1> <bed2>" unless @ARGV == 2;

my ($bed1, $bed2) = @ARGV;

my $bedfeatures1 = FeatureComp2::read_bed($bed1);  # a reference to an array of features. can dereference using @$bedfile1
my $bedfeatures2 = FeatureComp2::read_bed($bed2);


my @sortedfeats2 = sort sortNumeric @{$bedfeatures2};



for (my $i = 0; $i < @$bedfeatures1; $i++){
	 my $f1 = $bedfeatures1->[$i];
	 if (binarySearch($f1, \@sortedfeats2)){
                print $$bedfeatures1[$i]->{chrom}, "\t", $$bedfeatures1[$i]->{beg}, "\t", $$bedfeatures1[$i]->{end},"\n";
	}	
}



sub binarySearch {
	my ($item, $list) = @_;

	my $low = 0;
	my $high = scalar(@$list) - 1;
	
	while ($low <= $high) {   				## list indices
		my $mid = int(($low + $high)/2);
		my $guess = @$list[$mid];
		
		if (FeatureComp2::overlap($item, $guess)){	# $guess is a feature in the list. $item is a feature. 
			return 1;				# if overlap, return 1
		}

		if ($guess->{beg} > $item->{beg}) {		# item is first file. guess is second file. 
			$high = $mid - 1;
		}

		else {
			$low = $mid + 1; }
	}
	return 0;
}




sub sortNumeric {	#sort by beg/start
	$a->{beg} <=> $b->{beg};
}


