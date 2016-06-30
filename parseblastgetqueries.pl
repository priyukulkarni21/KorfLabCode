#!/usr/bin/perl
#variation on hashparse.pl parse blast output with hashes- key1 is query, key2 is search, value is score 
#priyanka kulkarni
#apr 21, 2015
#usage statement: ./parseblastgetqueries.pl blast.out

use strict; use warnings;

my ($input) = @ARGV;

open (my $in, "<", $input) or die "error reading ARGV[0] for reading";
open (my $out, ">", "$input.result2") or die "error writing to file";

my $query = "";
my %data;
my $count =0;
my $temp= "";
 

while (<$in>) {
	next until $_ =~ m/chr/;
	if ($_ !~ m/>/) {
		chomp;
		my $line = $_;
		$line =~ s/\s{2,80}/\t/g;    #if there are more than 2 spaces change those into tab
		my @list = split("\t", $line);
		if ($list[1] =~ m/[a-z]/){    #if list[1] has alphabet
			$query = $list[1];
		}
		elsif ($list[1] >= 35){		#if list[1] is a number (score) greater than 50
				$data{$query}{$list[0]} = $list[1];		#@hash{key1}{key2} = value;	key1 is query, key2 is search, value is score.	
		}
	}
}
close $in;

foreach my $qid (keys %data) { #for each my queryid in hash, print query
	if (scalar keys %{$data{$qid}} >=3){
		print $out("$qid\n");
    	$count++;
    	
		#foreach my $sid (keys %{$data{$qid}}) {		#for each of my searchids in hash{key1}
		#print $out("\t$sid\t$data{$qid}{$sid}\n");	#print search, and value
#	}	
	}
}
close $out;


__END__

