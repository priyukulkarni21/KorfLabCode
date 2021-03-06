#!/usr/bin/perl
use FeatureCompare;
use strict;
use warnings;

# Chromosome-indexed linear search: Read both files into hashes where the hash key is the chromosome 
# and the value is a reference to an array of features. Compare all features on the same chromosomes.

## Changes I still want to incorporate: 1) check whether to save unique results in  hash vs an array (saving in array here)
## 2) put sub read_bed into the FeatureCompare package

die "usage: $0 <bed1> <bed>" unless @ARGV == 2;

my ($bed1, $bed2) = @ARGV;

my $bedfeatures1 = FeatureCompare::read_bed($bed1);  # a reference to an array of features. can dereference using @$bedfile1
my $bedfeatures2 = FeatureCompare::read_bed($bed2);

my $b1 = chrom_index($bedfeatures1);	# indexes the features by chrom. Hash key is chromosome and value is the feature.
my $b2 = chrom_index($bedfeatures2);


# Now, I want to call overlap on all features in the same chrs and then print.

my @results;
foreach my $chr (keys %$b1){
        my @feats = @{$b1->{$chr}};
        my @feats2 = @{$b2->{$chr}};
        foreach my $feature (@feats){		# the item is actually a ref to a hash
		my $find = 0;
                foreach my $feature2 (@feats2){
                        $find = FeatureCompare::overlap($feature, $feature2);
			if ($find == 1){   
				push(@results, $feature) unless grep{$_ eq $feature} @results;
			}	
                }
        }
}


# print out
foreach my $feature (@results){
	print $feature->{chrom}, "\t", $feature->{beg}, "\t", $feature->{end},"\n";
}



## a hash of hashes, so need to access that


# Now I have an array of features for each file. Now, I want to make a hash for each file where the key is hte chromosome, and the value is the arr of features.
# The way to do that is to go through each array of features, and assign each item in the array to a particular chromosome key.

sub chrom_index {
	my ($features) = @_;
	my %bed;

	foreach my $feature (@$features){
		my $chr = $feature->{chrom};
		push (@{$bed{$chr}}, $item);
	}
	return \%bed;
}
