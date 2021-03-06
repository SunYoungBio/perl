#!/usr/bin/perl
#
#
use strict;
use warnings;
#aFile:
#Chr9    9934888 9935048 Chr9.3945       0.198162        9935040 T>A     T       9       0.642857142857143       A       5       0.357142857142857       other   0       0       14      0.4239502
#Chr9    9934888 9935048 Chr9.3945       0.198162        9935035 C>G     C       12      0.75    G       4       0.25    other   0       0       16      0.07681274
#Chr9    9934888 9935048 Chr9.3945       0.198162        9934952 A>T     A       26      0.541666666666667       T       22      0.458333333333333       other   0       0       48      0.6654658
#Chr9    9933214 9933561 Chr9.3941       0.2347025       9933541 C>T     C       12      0.521739130434783       T       11      0.478260869565217       other   0       0       23      1
#Chr9    9933214 9933561 Chr9.3941       0.2347025       9933465 C>A     C       22      0.814814814814815       A       5       0.185185185185185       other   0       0       27      0.00151372
#
#bFile:
#Chr10   57887   58028   Chr10.14        0.1235855       57887   A>T
#Chr10   58099   58540   Chr10.15        0.31612343      58174   T>A
#Chr10   58099   58540   Chr10.15        0.31612343      58175   T>A
#Chr10   58099   58540   Chr10.15        0.31612343      58469   G>T
#Chr10   66779   67416   Chr10.19        0.30691764      67001   G>A
#Chr10   66779   67416   Chr10.19        0.30691764      67090   T>C
#Chr10   66779   67416   Chr10.19        0.30691764      67342   G>A
#Chr10   81011   81254   Chr10.29        0.14059195      81120   A>G
#Chr10   82036   83004   Chr10.33        0.56447005      82230   C>G
#Chr10   83905   84095   Chr10.36        0.1564333       84025   T>A
#
#


my $f = $ARGV[0];
my %hash;
open IN, $ARGV[1] or die ;		#input aFILE;
while(<IN>){
	chomp;
	my @t = split;
	my $key;
	for(my $i=0; $i<$f; $i++){
		$key .="\t$t[$i]";
	}
	$hash{$key} = $_;
}
close IN;

open IN, $ARGV[2] or die ;		#input bFile
while(<IN>){
	chomp;
	my $key = "\t$_";
	if(exists $hash{$key}){
		print "$hash{$key}\n";
	}
}
close IN;