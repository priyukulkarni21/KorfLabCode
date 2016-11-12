package FeatureComparison; 
## FeatureComparison has the overlap function to compare two features and check if they intersect


#use strict; use warnings;


# A feature is simply a hash reference.
#my $feature = {
#chrom => 'A',
#beg => 100,
#end => 200,
#};
# for now, all I'm doing is just reading in the features and printing them!

sub overlap {
    my ($start1, $stop1, $start2, $stop2) = @_;
    if (($start1 <= $start2) and ($stop1 >=$start2)){return 1;}
    elsif(($start1 >= $start2) and ($start1 <=$stop2)){return 1;}
    else {return 0;}
}

1;
