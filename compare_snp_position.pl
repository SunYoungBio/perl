#!/usr/bin/perl
use strict;
use warnings;
#Ϊ��ʵ�֣��Ƚϲ�ͬ��SNPλ�㣬����4V�ϵ������ڵ�λ�����4V�ϴ��ڵ���������SNP���豣�����������磺
#	1.	4V�ϵ������ڵ�SNPλ�㣺ֻ��4VS_VS_4D�ϴ��ڵ�scafolds��
#	2.	4V��4A(or 4B)�Ͼ����ڵ�SNPλ�㣬�������Ͳ�һ�����磺scaffold100	100	A->T(4V)��A->G(4A)(or A->C(4B));

open IN, "$ARGV[0]" or die "����������ҪĿ��SNP�ļ�,$!";
my @targ_SNP = <IN>;
close IN;
open IN, "$ARGV[1]" or die "������ȶԵ�SNP�ļ�,$!";
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