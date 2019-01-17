#==> nipX9311_re1_2.nipref_snp_counts.txt <==
#      1 Chr10   10000035        CA
#      4 Chr10   1000017 TG
#      1 Chr10   1000020 GA
#      1 Chr10   1000022 TG
#      5 Chr10   1000042 CT
#      3 Chr10   10000434        AG
#     12 Chr10   1000067 AT
#     11 Chr10   1000070 TC
#      1 Chr10   10000979        CG
#      1 Chr10   10001333        AG
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
#my %hash;
my %hash1;
my @array;
open SNP, $ARGV[0] or die;	#input snp file;
while(<SNP>){
	chomp;
	my($count, $chr1, $pos, $snp) = (split, $_)[0,1,2,3];
	my $key = "$chr1\t$pos";
	#$KEY = "$key\t$snp";
	#$hash{$key} = '';
	$hash1{$key}{$snp} = $count;
}
close SNP;

open BED, $ARGV[1] or die;	#input BED file;

while(<BED>){
	chomp;
	my($chr2, $start, $end) = (split /\t/, $_)[0,1,2];
	my $start1 = $start;
	push  @array, "$_\t\#\t\#\t\#\n";
	while(1){
		my $key2 = "$chr2\t$start1";
		if(exists $hash1{$key2}){
				foreach my $snp(keys %{$hash1{$key2}}){
					if($array[-1]~~/\#/){pop @array};
					push @array, "$_\t$key2\t$snp\t$hash1{$key2}{$snp}\n";
				}
				
		}
		last if $start1 > $end;
		$start1 ++;
	}
}
close BED;	
print @array;
