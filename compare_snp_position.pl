#!/usr/bin/perl
use strict;
use warnings;
#为了实现：比较不同的SNP位点，即：4V上单独存在的位点或者4V上存在的特异类型SNP，需保留！！！比如：
#	1.	4V上单独存在的SNP位点：只有4VS_VS_4D上存在的scafolds；
#	2.	4V和4A(or 4B)上均存在的SNP位点，但是类型不一样，如：scaffold100	100	A->T(4V)和A->G(4A)(or A->C(4B));

open IN, "$ARGV[0]" or die "请先输入需要目标SNP文件,$!";
my @targ_SNP = <IN>;
close IN;
open IN, "$ARGV[1]" or die "请输入比对的SNP文件,$!";
my @comp_SNP = <IN>;
close IN;
my @filter_SNP;
foreach my $targ_SNP(@targ_SNP){
	push @filter_SNP, $targ_SNP;
	chomp $targ_SNP;
	my @t = split /\t/,$targ_SNP;
	foreach my $comp_SNP(@comp_SNP){
		chomp $comp_SNP;
		my @s = split /\t/,$comp_SNP;		
		if($t[0] =~ /$s[0]$/i){
			if($t[1] == $s[1]){
				if($t[2] =~ /$s[2]/i){
					pop @filter_SNP;
				}
			}
		} 
			
	}
}
print @filter_SNP;