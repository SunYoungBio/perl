#C418_W41126_SNP_reads.sorted.txt
#C418    Chr10   10002140        CT      8       100.00%
#C418    Chr10   10002143        GA      1       100.00%
#C418    Chr10   10002154        GT      1       100.00%
#C418    Chr10   10002159        CA      1       100.00%
#C418    Chr10   10002160        TA      1       100.00%
#W41126  Chr10   10000022        AG      18      100.00%
#W41126  Chr10   10000030        AT      10      100.00%
#W41126  Chr10   10000044        CT      1       100.00%
#W41126  Chr10   10000058        TG      13      100.00%
#C418_W41126     Chr10   10000106        AT      1       100.00% 56      96.55%
#C418_W41126     Chr10   10000116        GT      1       100.00% 1       100.00%
#C418_W41126     Chr10   10000122        TG      1       100.00% 1       100.00%
#C418_W41126     Chr10   10000128        AG      2       100.00% 45      97.83%

#[yangyang@node008 results]$ head ../C418/C418.seqdepth.txt 
#Chr1    984     1
#Chr1    985     2
#Chr1    986     3
#Chr1    987     3
#Chr1    988     4
#[yangyang@node008 results]$ head ../W41126/W41126.seqdepth.txt 
#Chr1    984     1
#Chr1    985     2
#Chr1    986     3
#Chr1    987     3
#Chr1    988     4
##############################################################################

#target:search SNP in W4116 sequencing depth from C418.seqdepth.txt 


#!/usr/bin/perl
use strict;
use warnings;

#perl xxx.pl xxx.seqdepth.txt xxx.seqdepth.txt xxx_SNP_reads.txt > xxxx

my %hashC;
open IN, $ARGV[0] or die $!;		#input C.seqdepth.txt file
while(<IN>){
	chomp;
	my($chr,$pos,$depth) = (split/\t/)[0,1,2];
	$hashC{$chr}{$pos}=$depth;
}
close IN;

my %hashW;
open IN, $ARGV[1] or die $!;		#input W.seqdepth.txt file
while(<IN>){
	chomp;
	my($chr,$pos,$depth) = (split/\t/)[0,1,2];
	$hashW{$chr}{$pos}=$depth;
}
close IN;

open IN, $ARGV[2] or die $!;		#C418_W41126_SNP_reads.sorted.txt
while(<IN>){
	chomp;
	my($chr,$pos) = (split/\t/)[1,2];
	unless(exists $hashC{$chr}{$pos}){
		$hashC{$chr}{$pos}='NA';
	}
	unless(exists $hashW{$chr}{$pos}){
		$hashW{$chr}{$pos}='NA';
	}
	print "$_\t$hashC{$chr}{$pos}\t$hashW{$chr}{$pos}\n";
}
close IN;