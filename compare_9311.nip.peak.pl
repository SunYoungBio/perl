#!/usr/bin/perl
use strict;
use warnings;

#file1:
#Chr8	3222	3548	Chr8.2	0.2549098
#Chr8	1006	1520	Chr8.1	2.5010047
#Chr8	10857	11028	Chr8.3	0.1736484
#Chr8	11077	11385	Chr8.4	0.36788264
#Chr8	12964	13148	Chr8.8	0.25682965
#Chr8	15343	15492	Chr8.11	0.12481792
#Chr8	16427	16846	Chr8.13	0.24900241
#Chr8	20530	20616	Chr8.14	0.09035575
#

#file2:
#9311_chr01	1006	1520	Chr8	1230	1245
#9311_chr01	1006	1520	Chr8	1266	1278
#9311_chr01	1006	1520	Chr8	12791	12791
#9311_chr01	1006	1520	Chr9	20173767	20173783
#
my %hash;
my %hash2;
open IN,$ARGV[0] or die;
while(<IN>){
	chomp;
	my($chr,$start,$end)=(split /\t/)[0,1,2];
	for(my$pos=$start;$pos<=$end;$pos++){
		$hash{$chr}{$pos} = "$chr\t$start\t$end";
	}
}
close IN;

open IN,$ARGV[1] or die;
while(<IN>){
	chomp;
	my($ninechr,$start,$end,$nipchr,$nipstart,$nipend)=(split /\t/)[0,1,2,3,4,5];
	while(1){
		if(exists$hash{$nipchr}{$nipstart}){
			my $result = "$ninechr\t$start\t$end\t$hash{$nipchr}{$nipstart}\n";
			unless(exists$hash2{$result}){
				$hash2{$result}='';
			}
		}
		$nipstart++;
		last if $nipstart>$nipend;
	}
}
close IN;

foreach my$result(sort keys %hash2){
	print "$result";
}