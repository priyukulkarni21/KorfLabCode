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

my $b1 = chrom_index($bedfeatures1);    # indexes the features by chrom. Hash key is chromosome and value is the feature.
my $b2 = chrom_index($bedfeatures2);


foreach my $chromosome (keys %$b1){
        my $feats1 = $b1->{$chromosome};
	my $feats2 = $b2->{$chromosome};
	my @sortedfeats2 = sort sortNumeric(@$feats2);

	foreach my $feature (@$feats1){                		# the item is actually a ref to a hash ## need to sort arr
		if (binarySearch($feature, \@sortedfeats2)){
			print $feature->{chrom}, "\t", $feature->{beg}, "\t", $feature->{end},"\n";
		}	 
	}
}


sub binarySearch {
	my ($item, $list) = @_;

	my $low = 0;
	my $high = scalar(@$list) - 1;
	
	while ($low <= $high) {   				## list indices
		my $mid = int(($low + $high)/2);
		my $guess =  @$list[$mid];
		
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



sub chrom_index {
        my ($features) = @_;
        my %bed;

        foreach my $item (@$features){
                my $chr = $item->{chrom};
                push (@{$bed{$chr}}, $item);
        }
        return \%bed;
}

