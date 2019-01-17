#!/usr/bin/perl
use strict;
use warnings;

#file A
#[yangyang@node013 re12]$ head nip_re12.9311ref_count5_snp_percent0.95.txt 
#ScaffoldUn01_2808       3695    AT      16      16      1.0000
#ScaffoldUn01_6245       2697    TC      6       6       1.0000
#ScaffoldUn01_3759       2102    CT      17      17      1.0000
#Scaffold09_70   1822    AT      173     178     0.9719
#ScaffoldUn01_3356       3194    GT      80      81      0.9877
#ScaffoldUn01_13331      853     AG      8       8       1.0000
#ScaffoldUn01_13331      1176    AG      74      74      1.0000
#Scaffold07_289  7370    GA      9       9       1.0000
#Scaffold07_289  7250    CT      25      25      1.0000
#Scaffold07_289  26338   TC      17      17      1.0000
#
#file B
#same A


my %snp;
my %read;
open IN,$ARGV[0] or die $!;			#input A(e.g:C418_SNP_Depth.txt)
while(<IN>){
	chomp;
	my @t=split;
	my $chr = $t[0];
	my $pos = $t[1];
	my $snp = $t[2];
	my $read = $t[3];
	my $depth = $t[4];
	my $percent = $t[5];
	my $readmes="$read\t$depth\t$percent";
	$snp{$chr}{$pos}=$snp;
	$read{$chr}{$pos}{$snp}=$readmes;
}
close IN;

open IN,$ARGV[1] or die $!;			#input B(e.g:W41126_SNP_Depth.txt)
while(<IN>){
	chomp;
	my @t=split;
	my $chr = $t[0];
	my $pos = $t[1];
	my $snp = $t[2];
	my $read = $t[3];
	my $depth = $t[4];
	my $percent = $t[5];
	my $readmes="$read\t$depth\t$percent";
	unless(exists $snp{$chr}{$pos}){
		print "B\t$_\n";
	}else{
		if($snp{$chr}{$pos} eq $snp){
			delete $snp{$chr}{$pos};
			delete $read{$chr}{$pos}{$snp};
		}else{
			my $snpone = $snp{$chr}{$pos} ;
			$snpone =~ /(\w)(\w)/;
			my $Pone = $2;
			$snp =~ /(\w)(\w)/;
			my $Ptwo = $2;
			my $snpSub = $Pone.$Ptwo;
			print "A_B\t$chr\t$pos\t$snpSub\t$read{$chr}{$pos}{$snpone}\t$read\t$depth\t$percent\n";
			delete $snp{$chr}{$pos};
			delete $read{$chr}{$pos}{$snpone};			
		}
	}
}
for my $chr (keys %read){
	for my $pos (keys %{$read{$chr}}){
		for my $snp (keys %{$read{$chr}{$pos}}){
			$snp =~ /(\w)(\w)/;
			my $snpSub = $2.$1;
			print "A\t$chr\t$pos\t$snpSub\t$read{$chr}{$pos}{$snp}\n"
		}
	}
}
close IN;