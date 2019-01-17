#!/usr/bin/perl
use strict;
use warnings;

#input snp:
#input file is snp distributed in peaks;
#Chr10   45310   45570   Chr10.5 0.115314215     45338   A>G
#Chr10   45310   45570   Chr10.5 0.115314215     45378   A>T
#Chr10   45310   45570   Chr10.5 0.115314215     45388   A>G
#Chr10   45310   45570   Chr10.5 0.115314215     45504   C>T
#Chr10   45310   45570   Chr10.5 0.115314215     45515   A>G
#Chr10   57351   57485   Chr10.12        0.11804472      57359   T>G
#Chr10   58095   58532   Chr10.14        0.31013107      58174   T>A

#if input file is all snp;
#Chr10  58175   TA
#Chr10  58469   GT
#Chr10  58481   GA


#input .sam from bowtie
#HWI-7001446:655:C9080ANXX:8:1101:1963:2046	77	*	0	0	*	*	0	0	TCCTTTGAGAGGTTCGTGCCTTGTTTCCTCCTTTTGTGCTGCGATCTCTGGATTCTGGAAACTTCTCAAGTCCTCGGCTTTACATTCTTGGTGTGGAGCGGTTATACCCCGGGGTTAACTTTTCG	BB<<BBBFFBFFF//FFFFFFFFF/BFF<FF<FF<FB/<<<<B/<F/</FF</<BF/BBFBF/</<F<//B<<FF/B<F//<</<<F<B/F/FFBFFBF</<7B/<FB#################	YT:Z:UP
#HWI-7001446:655:C9080ANXX:8:1101:1963:2046	141	*	0	0	*	*	0	0	AATTTTAAAAAAACCAAATTAGCTTCCATAAAATTGCTAAGTCTTGTTTGTGAAACCTATTAGCCGGTTTTCTTACCGTGTTGACCGAAAGTCATGGCTTTTTACTGGTTTTCTGTAAACCGATG	/<BBBFF<FBFFFFFFF</F/BFFFFFBFFFFFF<BFFFFF<FF/BBF/BBFFBFFFFBF<FBFFFF7///</F/<BF<FFF<B/FB//</<<<//BBBFBF#######################	YT:Z:UP
#HWI-7001446:655:C9080ANXX:8:1101:1952:2085	83	Chr12	24835792	42	125M	=	24835663	-254	ACATCATATACTTGAAACTTCCTGTTCAATTGGACATCTACCAGGATACTATTGAACATGAGTAATATTGTTGTTGCACTACATCCCAACCATGATCTTTGGACAACAAGTTTAAAGAGTTTGCA	####################BFFF<B//</FFFF</B<<<<//F/FFFF<FFFF<</B/</F</<FFF<</FFF<<<//</7<</////B</FFBFFFFF/FBF<<BFFBB/F<<BB//<BBB<B	AS:i:-8	XN:i:0	XM:i:3	XO:i:0	XG:i:0	NM:i:3	MD:Z:19C64A1A38	YS:i:-13	YT:Z:CP
#HWI-7001446:655:C9080ANXX:8:1101:1952:2085	163	Chr12	24835663	42	125M	=	24835792	254	TACATACGATGTATGATTATCTGCAATAACTCTAAGATCTGCAGGCTTCACTTTAATGAGGCACACTCCTACACGAAATTAACAACGAGCTGTTAAATTCAGCATTTTAATGTGGCCCTGCAACT	<<<</<///FF<<<</B/<<F<FF<FF<FF/BBB/<//<FBF</<</<<<BFB/FB/BBFBBFFFF<BFBFFF/<<F################################################	AS:i:-13	XN:i:0	XM:i:5	XO:i:0	XG:i:0	NM:i:5	MD:Z:7T9G55A12T27C10	YS:i:-8	YT:Z:CP
#HWI-7001446:655:C9080ANXX:8:1101:1984:2117	99	Chr4	27357436	42	125M	=	27357667	356	TTTGTCGCACCACGGCAGCAAAATTATCGGATCTGAAATTCTGAATTGGCCAGAATTAGGTGGATATATGTTTGCATGTTTGAATTCTTCTCCCCCTGTGCTGTTTCTGTAGTGAAGTGCTATCT	B</BB/<FBFFFFFFFFBFFF/B///<///7<</<FFFF/F///<F////<F/B</</FF//<FFFF//<//<B/F<<<</BF<//<</F/<F<FFB///<BB######################	AS:i:-5	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:61T52T10	YS:i:-18	YT:Z:CP
#HWI-7001446:655:C9080ANXX:8:1101:1984:2117	147	Chr4	27357667	42	125M	=	27357436	-356	ATATCAAAGTTCACTCTGCATTCTTTCTTGTGCCATTTGCCGTGGAATTATGGCTGGACCTTTTACTACACTGACAACGTTGAGTTTTCGTTGGTACGTATCGAACATAATTTCTGAATTAGTCC	############################FFFBFF/<///</<//</F/<///</B/<<FFFF//BF<//<</</BFFBF/</</<BB/BFFB<<////<</<<//FF/FFFBB/B<</</BBBBB	AS:i:-18	XN:i:0	XM:i:7	XO:i:0	XG:i:0	NM:i:7	MD:Z:1G11A1G22A14A1C38A30	YS:i:-5	YT:Z:CP

open IN, $ARGV[0] or die $!;	#snp_in_peaks.txt
my %hash1;
my %hash2;
my %hash3;
my %hash4;
while(<IN>){
	chomp;
	s/\>//;
	next if $_~~/\#/;
	my @t = split;
	#----------------
	#my $chrpos = "$t[0]\t$t[5]";	#input file is snp distributed in peaks;
	#my ($ref,$ali) = (split //,$t[6])[0,1];
	#----------------
	my $chrpos = "$t[0]\t$t[1]";	#if input file is all snp;
	my ($ref,$ali) = (split //,$t[2])[0,1];
	$hash1{$chrpos}{$ref}=0;
	$hash2{$chrpos}{$ali}=0;
	$hash3{$chrpos}{non}=0;
	$hash4{$chrpos}=$_;
}	
close IN;

open IN, $ARGV[1] or die $!;	#input sam file
while(<IN>){
	chomp;
	next if !/MD:Z:/;
	my($chr,$star,$read) = (split /\t/,$_)[2,3,9];
	my $length = length $read;
	#my $n=0;
	for(my $n=0;$n<$length;$n++){
		my $star1 = $star+$n;
		my $chrpos = "$chr\t$star1";
		if(exists $hash1{$chrpos}){
			my $base = substr ($read,$n,1);
			if(exists $hash1{$chrpos}{$base}){
				$hash1{$chrpos}{$base}++;
			}
			elsif(exists $hash2{$chrpos}{$base}){
				$hash2{$chrpos}{$base}++;
			}else{
				$hash3{$chrpos}{non}++;
			}
		}
	#$n++;
	#last if $n == $length;
	}
}
close IN;

foreach my $chrpos (sort keys %hash1){
	foreach my $base (keys %{$hash1{$chrpos}}){
		foreach my $ali (keys %{$hash2{$chrpos}}){
		my $total = $hash1{$chrpos}{$base}+$hash2{$chrpos}{$ali}+$hash3{$chrpos}{non};
		my $refper;
		my $aliper;
		my $otherper;
		if($total==0){
			$refper=0;
			$aliper=0;
			$otherper=0;
		}else{
			$refper=$hash1{$chrpos}{$base}/$total;
			$aliper=$hash2{$chrpos}{$ali}/$total;
			$otherper=$hash3{$chrpos}{non}/$total;	
		}
		print "$hash4{$chrpos}\t$base\t$hash1{$chrpos}{$base}\t$refper\t$ali\t$hash2{$chrpos}{$ali}\t$aliper\tother\t$hash3{$chrpos}{non}\t$otherper\t$total\n";
		}
	}
}	
	
	
	
	
	
	
	
	
	
	
	
	
	
