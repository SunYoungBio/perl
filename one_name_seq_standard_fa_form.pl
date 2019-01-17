#!/usr/bin/perl
use strict;
use warnings;
open IN, $ARGV[0] or die "Can't open the fasta file $!\n";
my ($GeneName,%hash);
while(<IN>){
	s/\R//;
	if(/^(\>.*)/){
		$GeneName = $1;
	} else {
		#s/[^ATCGN]//ig;
		$hash{$GeneName} .= $_;
	}
}
close IN;
for(sort keys %hash){
	print "$_\n$hash{$_}\n";
}
