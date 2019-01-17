#Chr1	MSU_osa1r7	mRNA	2903	10817	.	+	.	ID=LOC_Os01g01010.1;Name=LOC_Os01g01010.1;Parent=LOC_Os01g01010
#Chr1	MSU_osa1r7	mRNA	2984	10562	.	+	.	ID=LOC_Os01g01010.2;Name=LOC_Os01g01010.2;Parent=LOC_Os01g01010
#Chr1	MSU_osa1r7	mRNA	11218	12435	.	+	.	ID=LOC_Os01g01019.1;Name=LOC_Os01g01019.1;Parent=LOC_Os01g01019
#Chr1	MSU_osa1r7	mRNA	12648	15915	.	+	.	ID=LOC_Os01g01030.1;Name=LOC_Os01g01030.1;Parent=LOC_Os01g01030
#Chr1	MSU_osa1r7	mRNA	16292	20323	.	+	.	ID=LOC_Os01g01040.1;Name=LOC_Os01g01040.1;Parent=LOC_Os01g01040
#Chr1	MSU_osa1r7	mRNA	16321	20323	.	+	.	ID=LOC_Os01g01040.2;Name=LOC_Os01g01040.2;Parent=LOC_Os01g01040
#Chr1	MSU_osa1r7	mRNA	16321	20323	.	+	.	ID=LOC_Os01g01040.3;Name=LOC_Os01g01040.3;Parent=LOC_Os01g01040
#Chr1	MSU_osa1r7	mRNA	16292	18304	.	+	.	ID=LOC_Os01g01040.4;Name=LOC_Os01g01040.4;Parent=LOC_Os01g01040
#Chr1	MSU_osa1r7	mRNA	22841	26971	.	+	.	ID=LOC_Os01g01050.1;Name=LOC_Os01g01050.1;Parent=LOC_Os01g01050
#Chr1	MSU_osa1r7	mRNA	22841	26971	.	+	.	ID=LOC_Os01g01050.2;Name=LOC_Os01g01050.2;Parent=LOC_Os01g01050
#Chr1	MSU_osa1r7	mRNA	27136	28651	.	+	.	ID=LOC_Os01g01060.1;Name=LOC_Os01g01060.1;Parent=LOC_Os01g01060
#Chr1	MSU_osa1r7	mRNA	29818	34493	.	+	.	ID=LOC_Os01g01070.1;Name=LOC_Os01g01070.1;Parent=LOC_Os01g01070
#Chr1	MSU_osa1r7	mRNA	29818	34493	.	+	.	ID=LOC_Os01g01070.2;Name=LOC_Os01g01070.2;Parent=LOC_Os01g01070
#Chr1	MSU_osa1r7	mRNA	29818	33943	.	+	.	ID=LOC_Os01g01070.3;Name=LOC_Os01g01070.3;Parent=LOC_Os01g01070
#Chr1	MSU_osa1r7	mRNA	35581	41180	.	+	.	ID=LOC_Os01g01080.1;Name=LOC_Os01g01080.1;Parent=LOC_Os01g01080
#Chr1	MSU_osa1r7	mRNA	35581	41180	.	+	.	ID=LOC_Os01g01080.2;Name=LOC_Os01g01080.2;Parent=LOC_Os01g01080
#Chr1	MSU_osa1r7	mRNA	35581	41180	.	+	.	ID=LOC_Os01g01080.3;Name=LOC_Os01g01080.3;Parent=LOC_Os01g01080
#

#snp file
############################################################
#C418	Chr10	10000040	AG	1	100.00%
#C418	Chr10	10000081	GC	1	100.00%
#C418	Chr10	10000107	GA	1	100.00%
#C418	Chr1	11218	AT	1	100.00%
#C418	Chr10	10000113	AT	1	100.00%
#C418	Chr10	10000126	TC	3	100.00%
#C418	Chr10	1000012	GT	1	100.00%
#C418	Chr10	10000168	AT	1	100.00%
#C418	Chr10	1000016	GA	1	100.00%
#C418	Chr10	10000214	CT	1	100.00%
#############################################################


#!/usr/bin/perl
use strict;
use warnings;
open ONE, $ARGV[0] or die;	#input gff file;
open TWO, $ARGV[1] or die;	#input snp file;

my %hash;
while(<ONE>){
	chomp;
	my($chr2, $start, $end, $strand, $geneMesage) = (split /\t/, $_)[0,3,4,6,8];
	my $start1 = $start;
	while(1){
		my $key = $chr2.$start1;
		$hash{$key} = "$geneMesage";
		last if $start1 > $end;
		$start1 ++;
	}
}
	
while(<TWO>){
	chomp;
	my($chr1, $pos, $snp) = (split /\t/, $_)[1,2,3];
	my $key = $chr1.$pos;
	if(exists $hash{$key}){
		print "$chr1\t$pos\t$snp\t$hash{$key}\n";
	}else{
		print "$chr1\t$pos\t$snp\t\.\n";
	}
}
close ONE;
close TWO;
