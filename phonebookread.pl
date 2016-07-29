#!/usr/bin/perl
# phone book
use strict;
use warnings;

my ($input) = @ARGV; 
open (my $fh, "<", $input) or die "error reading ARGV[0] for reading";

# put phonebook into hash
my %phonebook = ();

while (<$fh>){
	my ($name, $phone) = split(/\t/, $_);
	$phonebook{$name} = $phone;
	}
close $fh;
# print phonebook

foreach my $key(sort keys %phonebook){
	print $key, "\t", $phonebook{$key}, "\n";
}


