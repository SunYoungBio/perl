#!/usr/bin/perl
use strict;
use warnings;

open IN, "$ARGV[0]" or die "can not open the target SNP file!$!";
my ($n, $x);
my @t;
while(<IN>){
	chomp;
	push @t, split;
}
close IN;
print "$t[0][1]";

for($n=0; $n<scalar@t; $n++){
	for($x=1; ;$x++){
		if($t[$n][0] eq $t[$n+$x][0]){
			if(($t[$n][1] < $t[$n+$x][1]-30)&($t[$n][1] > $t[$n+$x][1]+30)){
				next;
			}
		}
	
	print "$t[$n]\t$t[$n+1]\t$t[$n+2]\n";
	last;
	}
}