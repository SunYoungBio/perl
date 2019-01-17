#!/usr/bin/perl
use warnings;
use strict;

#input files format:
#FILE1:The 9311 genome into nip genome
#9311	chr01	1003	Chr9	20173764	
#9311	chr01	1004	Chr9	20173765	
#9311	chr01	1005	Chr9	20173766	
#9311	chr01	1006	Chr9	20173767	C>A
#9311	chr01	1007	Chr9	20173768	
#9311	chr01	1008	Chr9	20173769	
#9311	chr01	1009	Chr9	20173770	
#
#FILE2:The 9311 peaks
#9311_chr01	1006	1520	9311_chr01.1	2.5010047
#9311_chr01	3222	3548	9311_chr01.2	0.2549098
#9311_chr01	10857	11028	9311_chr01.3	0.1736484
#9311_chr01	11077	11385	9311_chr01.4	0.36788264
#9311_chr01	12964	13148	9311_chr01.8	0.25682965
#9311_chr01	15343	15492	9311_chr01.11	0.12481792
#9311_chr01	16427	16846	9311_chr01.13	0.24900241
#9311_chr01	20530	20616	9311_chr01.14	0.09035575
#9311_chr01	23112	23341	9311_chr01.15	0.35850766
#9311_chr01	27155	27234	9311_chr01.19	0.09428665
#9311_chr01	27301	27800	9311_chr01.20	0.9003892
#9311_chr01	30091	30455	9311_chr01.24	0.7335499
#9311_chr01	34441	34876	9311_chr01.25	0.34796378
#9311_chr01	35102	35471	9311_chr01.26	0.39778578
#9311_chr01	35795	36269	9311_chr01.28	0.60336894

############################################

#Usage:perl xxx.pl infile1.9311TOnip.txt 	infile2.9311peaks.txt 	outfile1.show.txt 	outfile2.temp.txt

open FILE1, $ARGV[0] or die;
my %hash;
while(<FILE1>){
	chomp;
	my($name,$chr,$pos,$nipchr,$nippos)=(split/\t/)[0,1,2,3,4];
	my $ninename=$name.'_'.$chr;
	$hash{$ninename}{$pos}="$nipchr\t$nippos";
}
close FILE1;

open FILE2,$ARGV[1] or die;
open OUT1, "> $ARGV[2]" or die;
open OUT2, "> $ARGV[3]" or die;

my %hash2;
while(<FILE2>){
	chomp;
	my($pninename,$start,$end)=(split /\t/)[0,1,2];
	for(my$i=0;$i<=$end-$start;$i++){
		my $posion=$start+$i;
		if(exists $hash{$pninename}{$posion}){
			my($rawCHR,$rawPOS)=(split/\t/,$hash{$pninename}{$posion})[0,1];
			$hash2{$rawCHR}{$rawPOS}='';
		}
	}
	next unless %hash2;
	print OUT1 "$pninename\t$start\t$end\t";
	
	foreach my $nipCHR(sort keys %hash2){
		my @array=sort{$a<=>$b} keys %{$hash2{$nipCHR}};
		my $start2=$array[0];
		my $end2=$array[-1];
		print OUT1 "$nipCHR\:$start2\>";
		print OUT2 "$pninename\t$start\t$end\t$nipCHR\t$start2\t";
		for(my$i=0;$i<$#array;$i++){
			if($array[$i+1]-$array[$i]!=1){
				print OUT1 "$array[$i]\;$nipCHR\:$array[$i+1]\>";
				print OUT2 "$array[$i]\n$pninename\t$start\t$end\t$nipCHR\t$array[$i+1]\t";
			}
		}
		print OUT1 "$end2\;";
		print OUT2 "$end2\n";
	}
	print OUT1 "\n";
	undef %hash2;
}
close FILE2;
close OUT1;
close OUT2;