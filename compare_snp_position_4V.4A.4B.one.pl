#!/usr/bin/perl
use strict;
use warnings;
open IN, "$ARGV[0]" or die "Please input target SNP file,$!";
while(<IN>){
	my @t = split;
	print "$t[0]\t$t[1]\t$t[2]\t$t[3]\t$t[4]\n" if (($t[3] ne 'NULL') and ($t[4] ne 'NULL'));
}
close IN;