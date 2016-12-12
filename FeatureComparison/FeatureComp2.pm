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
        if ($f1->{chrom} eq $f2->{chrom}){
               if (($f1->{beg} <= $f2->{beg}) and ($f1->{end} >= $f2->{beg})){return 1;}
               elsif(($f1->{beg} >= $f2->{beg}) and ($f1->{beg} <= $f2->{end})){return 1;}
               else {return 0;}
 	}       
}



sub read_bed {
        my ($file) = @_;
        my @arr;
        open (my $in, $file) or die "error reading file";
        while (<$in>){
                chomp;
                my ($chr, $start, $stop) = split (/\t/, $_);
                push @arr, {
                        chrom => $chr,
                        beg  => $start,
                        end => $stop,
                };
        }
        close $in;
        return \@arr;
}

1;
