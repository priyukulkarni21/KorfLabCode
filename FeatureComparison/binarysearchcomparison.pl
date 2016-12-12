#!/usr/bin/perl
use strict;
use warnings;
use FeatureComp2;

## Sorted list binary search
## Read a list of features into an array and sort it. Use a binary search to compare features.
# Trying it out a simple one with just read bed, no chr/location hashing yet


die "usage: $0 <bed1> <bed2>" unless @ARGV == 2;

my ($bed1, $bed2) = @ARGV;

my $bedfeatures1 = FeatureComp2::read_bed($bed1);  # a reference to an array of features. can dereference using @$bedfile1
my $bedfeatures2 = FeatureComp2::read_bed($bed2);

my $b1 = chrom_index($bedfeatures1);    # indexes the features by chrom. Hash key is chromosome and value is the feature.
my $b2 = chrom_index($bedfeatures2);


foreach my $ch (keys %$b1){
        my @arr = @{$b1->{$ch}};
	my @arr2 = @{$b2->{$ch}};
	my @slist2 = sort sortNumeric(@arr2);
        
	foreach my $item (@arr){                # the item is actually a ref to a hash ## need to sort arr
		if (binary_Search($item, \@slist2)){
			print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end},"\n";
		}		
 
	}
}



sub binary_Search {
	my ($item, $list) = @_;

	my $low = 0;
	my $high = scalar(@$list) - 1;
	
	while ($low <= $high){    ## list indices
		my $mid = (($low + $high)/2);
		my $guess =  @$list[$mid];
		
		if (FeatureComp2::overlap($item, $guess)){	# $guess is a feature in the list. $item is a feature. 
								# if it's an overlap, it will return mid. If not, then continue: then check if beg was higher or if lower, and look accordingingly
			return 1;
		}

		elsif ($guess->{beg} > $item->{beg}) {		 # item is first file. guess is second file. 
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

