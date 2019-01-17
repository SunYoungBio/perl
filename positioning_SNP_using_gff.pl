#!/usr/bin/perl
use strict;
use warnings;

#---------------------------------------------------------------------------------------------------
#为了确定SNP落在基因组上的序列注释位置；
#the format of gff:
#scaffold9930	fgenesh	mRNA	317426	327522	.	-	.	ID=AEGTA00001;Type=multi-exon;
#scaffold9930	fgenesh	CDS	317426	317527	4.41	-	0	Parent=AEGTA00001;
#scaffold9930	fgenesh	CDS	317630	317705	3.78	-	1	Parent=AEGTA00001;
#scaffold9930	fgenesh	CDS	317779	318035	23.04	-	0	Parent=AEGTA00001;

#the format of SNP description:
#scaffold9930	44	GC
#AACGCGCTAGCTAGCGGGCCT...CACGCATCGGC
#scaffold9930	35	AT
#AACGCGCTAGCTAGCGGGCCT...CACGCATCGGC
#scaffold9930	60	AT
#AACGCGCTAGCTAGCGGGCCT...CACGCATCGGC
#scaffold9930	60	AT
#---------------------------------------------------------------------------------------------------
open IN, "$ARGV[0]" or die "can not open the SNP file!$!";
my @SNP_des = <IN>;
close IN;
open IN, "$ARGV[1]" or die "can not open the SNP file!$!";
my @GFF_fil = <IN>;
close IN;

my @SNP_res =();
foreach my $SNP_des(@SNP_des){
	push @SNP_res, $SNP_des;
	chomp $SNP_des;
	$SNP_des =~ s/\r//;
	my @t = split "\t", $SNP_des;
	foreach my $GFF_fil(@GFF_fil){
		chomp $GFF_fil;
		my @s = split "\t", $GFF_fil;
		if($t[0] eq $s[0]){
			if(($t[1]>$s[3]) and ($t[1]<$s[4])){
				pop @SNP_res if $SNP_res[-1] !~ /\t\w+\t\w+\t\w+\t\w+\t/;
				push @SNP_res, "$t[0]\t$t[1]\t$t[2]\t$s[2]\t$s[3]\t$s[4]\n";
			}
		}
	}
}
print @SNP_res;