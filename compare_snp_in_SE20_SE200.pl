#!usr/bin/perl
use warnings;
use strict;

#==> 9311.SE200_snp_percent_1.00.txt <==
#Chr10   2493934 AG      17      1.0000
#Chr10   19973343        TC      24      1.0000
#Chr10   19595159        CT      1       1.0000
#Chr10   9280425 CT      132     1.0000
#Chr10   15455800        TC      80      1.0000
#Chr10   18460222        GA      16      1.0000
#Chr10   9582775 CG      130     1.0000
#Chr10   6354474 TA      5       1.0000
#Chr10   890004  TC      8       1.0000
#Chr10   6395237 GA      2       1.0000
#
#==> 9311.SE20_snp_percent_1.00.txt <==
#Chr10   2211942 AC      1       1.0000
#Chr10   19253005        GA      1       1.0000
#Chr10   3685949 CT      1       1.0000
#Chr10   7219674 CT      16      1.0000
#Chr10   484515  AC      3       1.0000
#Chr10   17678703        AG      9       1.0000
#Chr10   21195938        TG      20      1.0000
#Chr10   2915339 GA      3       1.0000
#Chr10   12125062        GC      1       1.0000
#Chr10   5431109 GT      6       1.0000
#

my %hash;
open IN, $ARGV[0] or die;	#save file A
while(<IN>){
	chomp;
	my @t = split;
	$hash{$t[0]}{$t[1]} = $t[2];
}

close IN;

open IN, $ARGV[1] or die;	#search file B
while(<IN>){
	chomp;
	my @t = split;
	unless(exists $hash{$t[0]}{$t[1]}){
		print "$_\n";
	}
}
close IN;