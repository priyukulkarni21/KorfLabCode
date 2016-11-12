#!/usr/bin/perl
#use strict; use warnings;
use List::MoreUtils qw/ uniq /;
use FeatureComparison;

## Open up one file and grab the first feature. Open up a second file and compare the feature to all other features. Repeat until done.

## as many lines as there are in the first file, open it up. 

my $count = 0;

open (my $in, "<", $ARGV[0]);
while(<$in>){
	$count++
}

## count will have the number of lines in the bedfile, so we know how many times we need to open it to reach the last line. 
close $in;

my @arr;
my $find = 0;
for (my $i = 1; $i <= $count; $i++){    # for as many times as there are lines in the first file open the file
        $find = 0;
	my $chr1;
	my $start1;
	my $stop1;

	open(my $in, "<", $ARGV[0]);    

        while(<$in>){   
		#$find = 0;                # while in the file, print the line if the line number is equal to the line desired.
        	chomp;
		my $line = $_;
		(($chr1, $start1, $stop1) = split(/\t/, $line)) if ($. == $i);  # get the feature equal to the line num we want in the for iteration;
	}	

	open(my $in2, "<", $ARGV[1]);
	
	while(<$in2>){
		chomp;
		my ($chr, $start, $stop) = split(/\t/, $_);
		if ($chr1 == $chr){
			$find = FeatureComparison::overlap($start1, $stop1, $start, $stop);	#overlap function in FeatureComparison library	
			if ($find == 1){		
				my $str = "$chr1\t$start1\t$stop1\n";
				push (@arr, $str);
				$find = 0;
			}
		}
	}
	close $in;
	close $in2;
}     
print uniq(@arr);







__END__


print  overlap(\%feature);



}
close $in;


sub overlap{
         my ($f1) = shift;
         return $f1->{chr};
}







foreach my $chr(keys %feature2){
        foreach my $beg(keys %{$feature2{$chr}}){
                foreach my $end(keys %{$feature2{$chr}{$beg}}){
                      print $chr, "\t", $beg, "\t", "$end", "\n";
                }
        }
}


open(my $in2, "<", $ARGV[1]);
my %feature2;
while(<$in2>){
         chomp;
         my ($chr, $start, $stop) = split(/\t/, $_);
         $feature2{$chr}{$start}{$stop} = 1;
}
close $in2;

foreach my $chr(keys %feature2){
        foreach my $beg(keys %{$feature2{$chr}}){
                foreach my $end(keys %{$feature2{$chr}{$beg}}){
                        print $end, "\n";
                }
        }
}

for (my $i = 1; $i <= $count; $i++){	# for as many times as there are lines in the first file open the file
	open(my $in, "<", $ARGV[0]);	
	while(<$in>){			# while in the file, print the line if the line number is equal to the line desired.
	print ($_, "\n") if ($. == $i);
	}
	
}
