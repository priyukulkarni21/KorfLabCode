#!/usr/bin/perl
use strict; use warnings;
use List::MoreUtils qw/ uniq /;
use FeatureComp2;

## Open up one file and grab the first feature. Open up a second file and compare the feature to all other features. Repeat until done.
## as many lines as there are in the first file, open it up.

unless (@ARGV == 2) {die "usage: ./FeatureComp2.pl <bed1> <bed2>"};


## Count the lines in the first bed file

open(my $in, "<", $ARGV[0]) or die "error opening $ARGV[0] for reading";	
my $count =0;
while(<$in>){
	$count++
}
close $in;
	
## Read files in and compare

my %feature;
my %feature2;
my $find = 0;
my @arr;
for (my $i = 0; $i <= $count; $i++){		# for each of the lines in first bed file
	$find = 0;
	my $chr1;
	my $start1;
	my $stop1;
	open (my $in, "<", $ARGV[0]);		# open the file
	while(<$in>){				
        	chomp;
		my $line = $_;
		(($chr1, $start1, $stop1) = split(/\t/, $line)) if ($. == $i);	# split on tabs and save in array if line number matches the counter
		%feature = (					# set up the hash
			chr => $chr1, 		
			beg => $start1,
			end => $stop1,
			);
	}
	close $in;

	open (my $in2, "<", $ARGV[1]) or die "error opening $ARGV[1] for reading";	# open file 2
	while (<$in2>){
		chomp;
		my ($chr2, $start2, $stop2) = split(/\t/, $_);	# split each line and save in hash
		%feature2 = (
			chr => $chr2,
			beg => $start2,
			end => $stop2,
			);
		
		$find = FeatureComp2::overlap(\%feature, \%feature2);	# call overlap in FeatureComp2 package. returns 0 or 1.

		if ($find == 1){	# if find is 1, which means found an overlap, then push onto array that feature from file 1
			my $str = "$feature{chr}\t$feature{beg}\t$feature{end}";
			push (@arr, $str);
			$find = 0;	# reset find;
		}		
	}
	close $in2;
}

my @arr2 = uniq(@arr);	# get unique array vals
$" = "\n";		
print "@arr2","\n";	# print 




		
