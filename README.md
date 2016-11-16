# KorfLabCode
Code I wrote while in my MS, working in the Korf Lab

FeatureComparison: a common problem in bioinformatics is to find overlapping features, such as intersecting BED or GFF files. These are different ways to solve the same problem, and include/will include: array-based searches, chr-indexed searches, linear search vs binary search, and more. 

InterviewPractice: tackling some more of the common problems in bioinformatics with Perl

_phonebookread.pl_ : a very simple phonebook reader using a hash. I will be practicing with various algorithms, so I want to put some of that initial code in here before I play with more complex things.

_BinarySearchPerl.pl_ : binary search algorithm using Perl.

_getseqs.pl_ : takes a list of fasta sequences and also a larger fasta file, and returns the sequences that are found from the list in the larger fasta file.

_BLASToutputparser_to_NEXUSformat.pl_ : takes BLAST output (nucleotide) and parses it; can change some parameters within code, like setting a threshold score cutoff. Finally, also allows to output a distance matrix into a NEXUS format, which can be used to visualize a phylogenetic tree on programs like SplitsTree.
