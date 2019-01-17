#snp.txt
#9311    chr01   1006    Chr9    20173767        C>A
#9311    chr01   1069    Chr8    1266    T>A
#9311    chr01   1168    Chr8    16189642        A>G
#9311    chr01   1170    Chr8    16189644        C>G
#9311    chr01   1173    Chr8    16189647        A>T
#9311    chr01   1201    Chr4    34881200        A>C

#input all snp file
#Chr4    34881199        C>T
#Chr4    23885775        A>G
#Chr1    20847   A>C
#

#peaks.bed
#Chr10   45479   45513   Chr10.1 0.09897461
#Chr10   45977   46040   Chr10.2 0.11131644
#Chr10   46147   46249   Chr10.3 0.114544265
#Chr10   46717   46909   Chr10.4 0.17284086
#Chr10   58100   58542   Chr10.5 0.7894509
#Chr10   58900   58969   Chr10.6 0.13486457
#Chr10   59557   59662   Chr10.7 0.13411896
#Chr10   66772   67418   Chr10.8 0.75849867
#Chr10   68044   68231   Chr10.9 0.13584685
#Chr10   68449   68845   Chr10.10        0.5714591
#



#!/usr/bin/perl
use strict;
use warnings;
my %hash;
my @array;
open SNP, $ARGV[0] or die;	#input snp file;
while(<SNP>){
	chomp;
	my($chr2, $pos, $snp) = (split /\t/, $_)[0,1,2];	#when input file is all snp
	$hash{$chr2}{$pos} = $snp;
}
close SNP;

open BED, $ARGV[1] or die;	#input BED file;

while(<BED>){
	chomp;
	my($chr1, $start, $end) = (split /\t/, $_)[0,1,2];
	my $start1 = $start;
	push  @array, "$_\t\#\t\#\n";
	while(1){
		if(exists $hash{$chr1}{$start1}){
			if($array[-1]~~/\#/){pop @array};
			push @array, "$_\t$start1\t$hash{$chr1}{$start1}\n";
		}
		last if $start1 > $end;
		$start1 ++;
	}
}
close BED;	
print @array;
