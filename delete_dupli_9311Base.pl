#!/usr/bin/perl
use strict;
use warnings;
#useage:perl xxx.pl input1 input2
#input1 and input2 format:
#9311	chr01	223910	Chr10	5653607	
#9311	chr01	223911	Chr10	5653606	
#9311	chr01	223912	Chr10	5653605	
#9311	chr01	223913	Chr10	5653604	
#9311	chr01	223914	Chr10	5653603	
#9311	chr01	223915	Chr10	5653602	
#9311	chr01	223916	Chr10	5653601	C>T
#9311	chr01	223917	Chr10	5653600	A>T
#9311	chr01	223918	Chr10	5653599	
#9311	chr01	223919	Chr10	5653598	
#9311	chr01	223920	Chr10	5653597	
#9311	chr01	223921	Chr10	5653596	
#9311	chr01	223922	Chr10	5653595	
#9311	chr01	223923	Chr10	5653594	
#9311	chr01	223924	Chr10	5653593	
#9311	chr01	223925	Chr10	5653592	
#9311	chr01	223926	Chr10	5653591	
#9311	chr01	223927	Chr10	5653590	
#9311	chr01	223928	Chr10	5653589	
#9311	chr01	223929	Chr10	5653588	
#9311	chr01	223930	Chr10	5653587	
#9311	chr01	223931	Chr10	5653586	
#9311	chr01	223932	Chr10	5653585	
#9311	chr01	223933	Chr10	5653584	
#9311	chr01	223934	Chr10	5653583	
#9311	chr01	223935	Chr10	5653582	

open IN, $ARGV[0] or die $!;

my %hash_9311;

while(<IN>){
	chomp;
	my($nine_name, $nine_chr,$nine_base,$Nip_chr,$Nip_base,$SNP_infor) = (split /\t/,$_,-1)[0,1,2,3,4,5];
			unless(exists $hash_9311{$nine_name}{$nine_chr}{$nine_base}){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "$Nip_chr\t$Nip_base\t$SNP_infor";
			}
			if($hash_9311{$nine_name}{$nine_chr}{$nine_base} ne "$Nip_chr\t$Nip_base\t$SNP_infor"){
				delete $hash_9311{$nine_name}{$nine_chr}{$nine_base};
			}
		}
close IN;

open IN, $ARGV[1] or die $!;
while(<IN>){
	chomp;
	my($nine_name, $nine_chr,$nine_base,$Nip_chr,$Nip_base,$SNP_infor) = (split /\t/,$_,-1)[0,1,2,3,4,5];
			unless(exists $hash_9311{$nine_name}{$nine_chr}{$nine_base}){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "$Nip_chr\t$Nip_base\t$SNP_infor";
			}
			if($hash_9311{$nine_name}{$nine_chr}{$nine_base} ne "$Nip_chr\t$Nip_base\t$SNP_infor"){
				delete $hash_9311{$nine_name}{$nine_chr}{$nine_base};
			}
		}
close IN;

foreach my $nine_name(sort keys %hash_9311){
	foreach my $nine_chr(sort keys %{$hash_9311{$nine_name}}){
		foreach my $nine_base(sort {$a<=>$b} keys %{$hash_9311{$nine_name}{$nine_chr}}){
			print "$nine_name\t$nine_chr\t$nine_base\t$hash_9311{$nine_name}{$nine_chr}{$nine_base}\n";
		}
	}
}