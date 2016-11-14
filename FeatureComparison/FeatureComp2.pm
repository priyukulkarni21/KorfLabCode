package FeatureComp2;
## FeatureComparison has the overlap function to compare two features and check if they intersect

use strict; use warnings;

# A feature is simply a hash reference.
#my $feature = {
#chrom => 'A',
#beg => 100,
#end => 200,
#};
# for now, all I'm doing is just reading in the features and printing them!

sub overlap {
        my ($f1, $f2) = @_;
        if (int($f1->{chr}) == int($f2->{chr})){
               if (($f1->{beg} <= $f2->{beg}) and ($f1->{end} >= $f2->{beg})){return 1;}
               elsif(($f1->{beg} >= $f2->{beg}) and ($f1->{beg} <= $f2->{end})){return 1;}
               else {return 0;}
 	}       
}
1;
