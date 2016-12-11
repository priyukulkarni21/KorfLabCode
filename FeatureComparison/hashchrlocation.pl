#!/usr/bin/perl
use FeatureComp2;
use strict;
use warnings;

# Approximate location hashing:
# This is similar to the below (chr-indexed linear search) except that not only is the chromosome indexed, but also the approximate location.
# For example, you could break up a chromosome into 100 segments or into 10kb pieces.

# Chromosome-indexed linear search: Read both files into hashes where the hash key is the chromosome 
# and the value is a reference to an array of features. Compare all features on the same chromosomes.

## Changes I still want to incorporate: 1) check whether to save unique results in  hash vs an array (saving in array here)
## 2) put sub read_bed into the FeatureComp2 package

die "usage: $0 <bed1> <bed>" unless @ARGV == 2;

my ($bed1, $bed2) = @ARGV;

my $bedfeatures1 = FeatureComp2::read_bed($bed1);  # a reference to an array of features. can dereference using @$bedfile1
my $bedfeatures2 = FeatureComp2::read_bed($bed2);

my $b1 = chrom_index($bedfeatures1);	# indexes the features by chrom. Hash key is chromosome and value is the feature.
my $b2 = chrom_index($bedfeatures2);

my %be1 = %$b1;
my %be2 = %$b2;
# Now, I want to call overlap on all features in the same chrs and then print.

my @results;
foreach my $ch (keys %be1){
	foreach my $sl (keys %{$be1{$ch}}){
		my $coor1 = $be1{$ch}{$sl};  #somehow, this $coor1 is an array
        	my $coor2 = $be2{$ch}{$sl};
		foreach my $c1 (@$coor1){
			foreach my $c2(@$coor2){
				if (FeatureComp2::overlap($c1, $c2)){
					push(@results, $c1) unless grep{$_ eq $c1} @results;
				}
			}
		}
	}
}


foreach my $item(@results){
	print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end},"\n";
}



## a hash of hashes, so need to access that


# Now I have an array of features for each file. Now, I want to make a hash for each file where the key is the chromosome, and the value is the arr of features.
# The way to do that is to go through each array of features, and assign each item in the array to a particular chromosome key.

sub chrom_index {
	my ($features) = @_;
	my %bed;

	foreach my $item (@$features){
		my $chr = $item->{chrom};
		my $slice1 = int($item->{beg}/10000); ## now slice is added in, and each slice is indexed based on the start coordinate location
		my $slice2 = int($item->{end}/10000);
		push (@{$bed{$chr}{"S$slice1"}}, $item);  ## add the slice in as a second key to the hash
		if ($slice1 != $slice2){
			push (@{$bed{$chr}{"S$slice2"}}, $item);
		}
	 
	}
	return \%bed;
}




__END__
