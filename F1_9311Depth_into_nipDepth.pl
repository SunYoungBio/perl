#!/usr/bin/perl
use strict;
use warnings;

#[yangyang@manager using_SE20_snp]$ cut -f 1,2,7,8 9311nip_re12_SE20_snp_base_distri.txt | head
#9311_chr01	10002042	T	11
#9311_chr01	10020123	A	5
#9311_chr01	10020672	A	5
#9311_chr01	10021445	C	4
#9311_chr01	10035964	T	8
#9311_chr01	10036924	T	4
#9311_chr01	10037758	A	5
#9311_chr01	10040599	A	1
#9311_chr01	10040852	C	11
#9311_chr01	10041881	T	10
#
#[yangyang@node010 all_snp_bias_depth_percent_plot]$ cut -f 1,2,4,5  9311nip_all_snp_in_all_reads.txt| head
#Chr1	10002225	A	10
#Chr1	10003695	A	24
#Chr1	10004913	C	0
#Chr1	10004950	C	17
#Chr1	10005439	T	11
#Chr1	10006238	C	6
#Chr1	10007110	C	2
#Chr1	10007227	G	5
#Chr1	10007851	A	6
#Chr1	10008646	C	2
#---
#[yangyang@node009 9311_mapping_Nip]$ head  9311.SE200_into_nip.txt 
#9311_chr01	1257	Chr4	1075	T>A
#9311_chr01	1258	Chr4	1076	T>A
#9311_chr01	1259	Chr4	1077	T>A
#9311_chr01	1260	Chr4	1078	T>A
#9311_chr01	1261	Chr4	1079	T>A
#9311_chr01	1262	Chr4	1080	T>A

#
my(%hash9311,%hashnip);
open IN, $ARGV[0] or die $!;	#input F1 SNP base distrbution using 9311ref
while(<IN>){
	chomp;
	my @t = split;
	#$hash9311{$t[0]}{$t[1]}{$t[2]}=$t[3];
	$hash9311{$t[0]}{$t[1]}=$t[3];
}
close IN;

open IN, $ARGV[1] or die $!;	#input F1 SNP base distrbution using nipref
while(<IN>){
	chomp;
	my @t = split;
	#$hashnip{$t[0]}{$t[1]}{$t[2]}=$t[3];
	$hashnip{$t[0]}{$t[1]}=$t[3];
}
close IN;

open IN, $ARGV[2] or die;	#input 9311 into nip SNP
while(<IN>){
	chomp;
	my @t = split;
	#my @SNP = split /\>/, $t[5];
	#my $scaffold9311 = ($t[0]."_".$t[1]);
	my $scaffold9311 = $t[0];
	#if (exists $hash9311{$scaffold9311}{$t[2]}{$SNP[1]} && exists $hashnip{$t[3]}{$t[4]}{$SNP[0]}){
	if (exists $hash9311{$scaffold9311}{$t[1]} && exists $hashnip{$t[2]}{$t[3]}){
		print "$t[2]\t$t[3]\t$scaffold9311\t$t[1]\t$t[4]\t$hashnip{$t[2]}{$t[3]}\t$hash9311{$scaffold9311}{$t[1]}\n";
	}
}
close IN;











