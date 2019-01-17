#!/usr/bin/perl
use strict;
use warnings;
open IN,$ARGV[0] or die $!;
my $snp;
while(<IN>){
	chomp;
	my @t=split;
	if($t[2]=~/(\w)(\w)/){
		$snp=$2.$1;
	}
	print "$t[0]\t$t[1]\t$snp\n"
}
