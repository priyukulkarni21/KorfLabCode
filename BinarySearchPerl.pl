#!/usr/bin/perl
# Binary Search algorithm in Perl
# Binary search is a fast way to search through lists and has O(log n) time efficiency.
# It needs a sorted array in order to work effectively. It is much better than simple search.
use strict;
use warnings;
#my ($file, $item) = @ARGV;  # use these if you want to have item be from command line. 
							 # for this example, I am just going to create item and file in the program	
#open (my $fh, "<", $file) or die "error opening @ARGV[0] for reading";

my $item = 4; # want to look for 4 in the list
my @listr = (1,5,6,4,8,10,12); #4's index should be 3

# For Binary Search, I need to sort my list before I can run the function
my @listr_sorted = sort @listr;

## To check if list is sorted, print out list elements in order:
#foreach my $loop_var (@listr_sorted){
#	print $loop_var, "\n";
#}
my $found_key = 0;
my $index;
my $mid;

sub binary_search {
	my @list = @{$_[0]};
	my $low = 0;
	my $high = scalar(@list) - 1;  #
	
	while (($low <= $high) && !$found_key){   
		$mid = int(($low + $high)/2);   
		
		if ($item == $list[$mid]){
			$found_key = 1;
			$index = int($mid);
		}
		elsif ($item < $list[$mid]){
			 $high = $mid - 1;	
		}
		else{
			 $low = $mid + 1;  #now, low = 3 and high is still 5
		}	
		
	}
	return $index;
}
$index = binary_search(\@listr_sorted, $item);
print "$item is at position $index \n";






