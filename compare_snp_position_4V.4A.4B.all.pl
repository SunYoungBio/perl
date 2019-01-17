#!/usr/bin/perl
use strict;
use warnings;
#为了实现：比较不同的SNP位点，即：4V上单独存在的位点或者4V上存在的特异类型SNP，需保留！！！比如：
#	1.	4V上单独存在的SNP位点：只有4VS_VS_4D上存在的scafolds；
#	2.	4V和4A(or 4B)上均存在的SNP位点，但是类型不一样，如：scaffold100	100	A->T(4V)和A->G(4A)(or A->C(4B));

open IN, "$ARGV[0]" or die "Please input target SNP file,$!";
my @targ_SNP = <IN>;
close IN;
open IN, "$ARGV[1]" or die "Please input 4AS_vs_4D.sam file,$!";
my @comp_SAM = <IN>;
close IN;
open IN, "$ARGV[2]" or die "Please input 4BS_vs_4D.sam file,$!";
my @comp_SAM1 = <IN>;
close IN;

my @filter_SNP;
my %allsnp;
push @filter_SNP, "Scaffold_name\tSNP_pos\t4D_4VS\t4D_4AS\tSNP.pos_in.read\tCIGAR\tMD\:Z\:\t4D_4BS\tSNP.pos_in.read\tCIGAR\tMD\:Z\:";
foreach my $targ_SNP(@targ_SNP){
	chomp $targ_SNP;
	$targ_SNP =~ s/\r//;
	my @s = split /\t/,$targ_SNP;
	my $scaNam = $s[0];
	my $snpPos = $s[1];
	push @filter_SNP, "\n$s[0]\t$s[1]\t$s[2]";

#--------------------------------------------------------------------------------------------------
	foreach my $comp_SAM(@comp_SAM){
		chomp $comp_SAM;
		$comp_SAM =~ /MD:Z:(\S+)/;
		my $mdz = $1;
		my @t=split /\t/, $comp_SAM;
        my $chr=$t[2];
        my $pos=$t[3];
        my $seq=$t[9];
		if($scaNam eq $chr){
			if(($snpPos < $pos + 100) and ($snpPos >= $pos) ){
				my $offset = $snpPos - $pos;
				my $basaReads=substr($seq,$offset,1);	
				push @filter_SNP, "\t4AS\:$basaReads\t$offset\t$t[5]\t$mdz";
				last;
			}
		}
	}
	if($filter_SNP[-1] !~ /4AS/){
		push @filter_SNP, "\tNULL\tNULL\tNULL\tNULL";
		}
#--------------------------------------------------------------------------------------------------	
	foreach my $comp_SAM1(@comp_SAM1){
		chomp $comp_SAM1;
		$comp_SAM1 =~ /MD:Z:(\S+)/;
		my $mdz1 = $1;
		my @t1=split /\t/, $comp_SAM1;
        my $chr1=$t1[2];
        my $pos1=$t1[3];
        my $seq1=$t1[9];
		if($scaNam eq $chr1){
			if(($snpPos < $pos1 + 100) and ($snpPos >= $pos1) ){
				my $offset1 = $snpPos - $pos1;
				my $basaReads1=substr($seq1,$offset1,1);
				push @filter_SNP, "\t4BS\:$basaReads1\t$offset1\t$t1[5]\t$mdz1";
				last;
			}
		}
	}
	if($filter_SNP[-1] !~ /4BS/){
		push @filter_SNP, "\tNULL\tNULL\tNULL\tNULL";
	}
}
print @filter_SNP;