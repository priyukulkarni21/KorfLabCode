package FeatureComp2;
## FeatureComparison has the overlap function to compare two features and check if they intersect

use strict; use warnings;

# A feature is simply a hash reference.
#my $feature = {
#chrom => 'A',
#beg => 100,
#end => 200,
#};

sub overlap {
        my ($f1, $f2) = @_;
        if ($f1->{chrom} eq $f2->{chrom}){

                if (($f1->{beg} <= $f2->{beg}) and ($f1->{end} >= $f2->{beg})){return 1;}
                elsif(($f1->{beg} >= $f2->{beg}) and ($f1->{beg} <= $f2->{end})){return 1;}
                else {return 0;}
        }
}
1;
