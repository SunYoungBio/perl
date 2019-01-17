##!/usr/bin/perl
##
##
use strict;
use warnings;
##aFile:
##Chr9    9934888 9935048 Chr9.3945       0.198162        9935040 T>A     T       9       0.642857142857143       A       5       0.357142857142857       other   0       0       14      0.4239502
##Chr9    9934888 9935048 Chr9.3945       0.198162        9935035 C>G     C       12      0.75    G       4       0.25    other   0       0       16      0.07681274
##Chr9    9934888 9935048 Chr9.3945       0.198162        9934952 A>T     A       26      0.541666666666667       T       22      0.458333333333333       other   0       0       48      0.6654658
##Chr9    9933214 9933561 Chr9.3941       0.2347025       9933541 C>T     C       12      0.521739130434783       T       11      0.478260869565217       other   0       0       23      1
##Chr9    9933214 9933561 Chr9.3941       0.2347025       9933465 C>A     C       22      0.814814814814815       A       5       0.185185185185185       other   0       0       27      0.00151372
##
#Chr1    386896  GT      3       1.0000
#Chr1    387193  TG      15      1.0000
#Chr1    387270  TC      20      1.0000
#Chr1    387338  GA      13      1.0000
#Chr1    387408  CT      13      1.0000
#Chr1    387578  CT      11      1.0000
#Chr1    387608  GA      3       1.0000
#Chr1    387808  TC      200     1.0000
#Chr1    388025  GC      83      1.0000
#Chr1    388032  AG      76      1.0000
#Chr1    389784  GA      3       1.0000
my %hash;
open IN, $ARGV[0] or die;	#search file A,SNP file
while(<IN>){
	chomp;
	my @t = split;
	$hash{$t[0]}{$t[1]} = $t[2];
}

close IN;

open IN, $ARGV[1] or die;	#save file B, BED and snp percnet file
while(<IN>){
	chomp;
	s/\>//;
	my @t = split;
	#$t[6] =~ s/\>//;
	next unless exists $hash{$t[0]}{$t[5]};
	if($hash{$t[0]}{$t[5]} eq $t[6]){
		print "$_\n";
	}
}
close IN;