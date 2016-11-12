#!/usr/bin/perl
use FeatureComparison;



print FeatureComparison::overlap(106, 174, 168, 207);
print FeatureComparison::overlap(20, 40, 10, 11);

print "\n\n";
my $chr1= 1;
my $start1 = 100;
my $stop1 = 200;

my %feature = (
	chr => $chr1,
	start => $start1,
	stop => $stop1,
	);

print $feature{chr}, "\n";
print $feature{start}, "\n";
print $feature{stop}, "\n";
