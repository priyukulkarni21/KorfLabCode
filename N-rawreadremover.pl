#!/usr/bin/perl
#Priyanka Kulkarni
#Friday, February 20th
#N raw read remover from fastq file - removes reads with N nucleotides and returns how
many rejected
use strict; use warnings;
die "usage: pskulkarni_N-rawread-remover.pl &lt;inputfq&gt; &lt;outputfq&gt;" if @ARGV ne
2;  #if not two ARGV list then print usage
my ($input, $output) = @ARGV;
open (my $in, "&lt;", $input) or die "error reading ARGV[0] for opening. Usage: program.pl
&lt;fastq file&gt;";
open (my $out, "&gt;", $output) or die "error writing to out file";
my %fastqhash;     #hash initialization
my $seqname_line = "";
my $seq_line = "";
my $third_line = "";
my $quality_line = "";
my $line_position = 0;
my $line = "";
my $rejected_count_N = 0;
#while loop: read file, only put those reads into a hash that have no N nucleotides in
sequence
while (&lt;$in&gt;){ # while reading file
        $line = $_;            #set line equal to the currrent line
        $line_position++;      #set a line_position for each line (1-4, then restarts
after 4)
        if ($line_position == 1){    #if line_position is 1 then set that to sequence name
                $seqname_line = $line;
line'
}
$third_line = $line;
}
elsif ($line_position == 2){
        $seq_line = $line;
}
elsif ($line_position == 3){
#if line pos is 2 then set that to sequence
#if line pos is 3 then set that to just 'third
#if line pos is 4 then set that to quality line
                #reset positions
    #if sequence doesn't have a N nucleotide then
        elsif ($line_position == 4){
                $line_position = 0;
                $quality_line = $line;
                if ($seq_line !~ m/N/){
add all 4 read lines into hash
$fastqhash{$seqname_line}{$seq_line}{$third_line}= $quality_line;
}
                elsif ($seq_line =~ m/N/){
hash and add 1 to the count of rejected reads
} }
#if sequence has N then don't add into
$rejected_count_N++;
}
close $in;  #close the input file
#for loops: print out to output file the contents of the hash, should look like original
#fastq file except without the low qualtiy N -related lines
foreach my $key (keys %fastqhash) {
        print $out($key);
        foreach my $key2 (keys %{$fastqhash{$key}}) {
                print $out($key2);
                foreach my $key3 (keys %{$fastqhash{$key}{$key2}}){
                        print $out($key3);
                        print $out($fastqhash{$key}{$key2}{$key3});
} }
#print number of rejected reads
print "Number of rejected reads: $rejected_count_N \n\n";
close $out;   #close output file