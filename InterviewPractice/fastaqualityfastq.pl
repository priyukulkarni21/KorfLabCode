#!/usr/bin/perl
use strict;
use warnings;

# Practice Interview Problems

die "usage: fastaqualityfastq.pl <phredscores def file> <fasta file> <qualityscores file>" unless @ARGV == 3;

#Your task is to convert the pair of FASTA plus quality files into a single FASTQ file in Illumina 1.8+ format. Write a program that performs this task in any language of your cho

my $qualityIllumina = read_phredscores($ARGV[0]);	# read the phredscores file and put into a hash
my $fasta = read_fasta($ARGV[1]); 			# read the fasta file, put into a hash
my $qualityscores = read_qualityscores($ARGV[2]);  	# read the quality scores and put into a hash




## for each identifier, print 1) the identifier 2) the fasta sequence 3) the random comment line is just a + here 4) the quality line

foreach my $identifier (keys %{$qualityscores}){
	print "$identifier", "\n";
	print @{$fasta->{$identifier}}, "\n";
	print "+\n";
	foreach my $val (@{$qualityscores->{$identifier}}){
		print $qualityIllumina->{$val};
	}
	print "\n";
}




## read in the FASTA file: 

sub read_fasta{
	open (my $in, "<", $ARGV[1]) or die "error opening $ARGV[1] for reading";
	my %fasta;
	my $id;
	my $seq;

	while (<$in>){	
		chomp;
		my $line = $_;

		if ($line =~ />/){
			$id = $line;
		}

		elsif ($line !~ />/){
			$seq = $line; 
			push @{$fasta{$id}}, $seq; 
		}
	}
	close $in;
	return \%fasta;
}



## read in the quality scores:

sub read_qualityscores{
	my ($file) = @_;
	open (my $in2, $file) or die "error opening for reading ARGV[2]";
	my %quals;
	my $quality;
	my $id;
       
	while (<$in2>){
		chomp;
		my $line = $_;
	
		if ($line =~ />/){
			$id = $line;
		}
		else {
			$quality = $line;
			my @q = split(/ /, $quality);	
			push @{$quals{$id}}, @q;
		}
	}
	close $in2;
	return \%quals;
}



## read the phredscores file and put in hash

sub read_phredscores{

	my ($file) = @_;
	open (my $in, $file);

	my @quality;

	while (<$in>){
		chomp;
		@quality = split(//, $_); 
	}
	close $in;

	#splice(@quality, 75);      		## Can change the parameters in this not currently being
						##  used splice if want to use something other than Illumina 1.8
	my %qualityIllumina;

	for(my $i = 0; $i < @quality; $i++){
		$qualityIllumina{$i} = $quality[$i];		#key is numerical score, value is quality character.
	}

	return \%qualityIllumina;
}












__END__
## just testing phredscores
foreach my $key (keys %{$qualityIllumina}){
	print $key, "\t", $qualityIllumina->{$key}, "\n";
}
_



#tesing fasta file:
#print "Hash content\n";
foreach my $k (keys %fasta) {
   foreach (@{$fasta{$k}}) {
      print $_, "\n";
   }
   print "\n\n";
}



#testing fq file:
foreach my $k (keys %qualityscores) {
   foreach (@{$qualityscores{$k}}) {
      print $_, "\n";
}}


