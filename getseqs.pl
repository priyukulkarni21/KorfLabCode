#!/usr/bin/perl
#take a fasta file as input and also a list of seqs and pull out those seqs that are matching
#tuesday april 21, 2015

use strict; use warnings;
my ($input, $input2) = @ARGV;

open (my $in, "<", $input) or die "error reading ARGV[0] for reading";
open (my $in2, "<", $input2) or die "error reading ARGV[0] for reading";

my @array;
while (<$in>){   #in should be the list of handles to get seq of, in2 the fasta seq of all /subset of lncrnas
	chomp;
	my $line =$_;
	push (@array, $line);
}

close $in;

my $line_position = 0;
my $handle;
my $sequence;
my %data;

while (<$in2>){
	chomp;
	my $line2 = $_;
	$line_position++;
	
	if ($line_position == 1){
		$handle = $line2;
	}
	
	if ($line_position == 2){
		$sequence = $line2;
		
		$line_position = 0;
	}
		
	$data{$handle} = $sequence;     #key is the handle and the value is the sequence
}

foreach my $key(keys %data){
	#print $key, "\n";
	for (my $i=0; $i< @array; $i++){
		#print $array[$i], "\n";
		if  ($key =~ /$array[$i]/){
			print $key, "\n", $data{$key}, "\n";
		}
	}
}			


close $in2;
