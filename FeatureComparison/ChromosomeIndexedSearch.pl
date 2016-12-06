#!/usr/bin/perl
use FeatureComp2;
use strict;
use warnings;

# Chromosome-indexed linear search: Read both files into hashes where the hash key is the chromosome 
# and the value is a reference to an array of features. Compare all features on the same chromosomes.

## Changes I still want to incorporate: 1) check whether to save unique results in  hash vs an array (saving in array here)
## 2) put sub read_bed into the FeatureComp2 package

die "usage: $0 <bed1> <bed>" unless @ARGV == 2;

my ($bed1, $bed2) = @ARGV;

my $bedfeatures1 = read_bed($bed1);  # a reference to an array of features. can dereference using @$bedfile1
my $bedfeatures2 = read_bed($bed2);

my $b1 = chrom_index($bedfeatures1);	# indexes the features by chrom. Hash key is chromosome and value is the feature.
my $b2 = chrom_index($bedfeatures2);


# Now, I want to call overlap on all features in the same chrs and then print.

my @results;
foreach my $chr (keys %$b1){
        my @arr = @{$b1->{$chr}};
        my @arr2 = @{$b2->{$chr}};
        foreach my $item (@arr){		# the item is actually a ref to a hash
		my $find = 0;
                foreach my $item2(@arr2){
                        $find = FeatureComp2::overlap($item, $item2);
			if ($find == 1){
                        	#$results{$item} = 1;    
				push(@results, $item) unless grep{$_ eq $item} @results;
			}	
                }
        }
}


# print out
foreach my $item(@results){
	print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end},"\n";
}



## a hash of hashes, so need to access that


# Now I have an array of features for each file. Now, I want to make a hash for each file where the key is hte chromosome, and the value is the arr of features.
# The way to do that is to go through each array of features, and assign each item in the array to a particular chromosome key.

sub chrom_index {
	my ($features) = @_;
	my %bed;

	foreach my $item (@$features){
		my $chr = $item->{chrom};
		push (@{$bed{$chr}}, $item);
	}
	return \%bed;
}




# For practice, I want to re-write the read_bed for features. A feature is just a hash reference wtih keys chrom, beg, end and values corresponding.

sub read_bed {
	my ($file) = @_;
	open (my $in, $file) or die "error opening $file for reading";
	my @features;

	while(<$in>){
		chomp;   #chomp off the newline for each line
		# for each line, also need to split on the tab delimiters and put into chrom, beg, end
		my ($chr, $start, $stop) = split(/\t/, $_);
	
		push @features, {   #for every single line in the bed file, there will be a feature entry.
			chrom => $chr,
			beg => $start,
			end => $stop,
		};
	}
	close $in;
	return \@features;

}

	

__END__

#to print it out:
foreach my $chr (keys %$b1){
        my @arr = @{$b1->{$chr}};
        foreach my $item (@arr){
                print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end},"\n";
        }
}





foreach my $chr (keys %$b1){
        my @arr = @{$b1->{$chr}};
        foreach my $chr2 (keys %$b2){
                my @arr2 = @{$b2->{$chr}};
                foreach my $item (@arr){
                        my $find = 0;
                        foreach my $item2(@arr2){
                                $find = FeatureComp2::overlap($item, $item2);
                                if ($find == 1){
                                print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end}, "\n";
                        }}
                }
        }

}


foreach my $chr (keys %$b1){
	my @arr = @{$b1->{$chr}};
	my @arr2 = @{$b2->{$chr}};
	foreach my $item (@arr){
		my $fid = 0;
		foreach my $item2(@arr2){
			$find = FeatureComp2::overlap($item, $item2);
			if ($find ==1){
				print $item->{chrom}, "\t", $item->{beg}, "\t", $item->{end}, "\n";
                        }
		}
        }
}



