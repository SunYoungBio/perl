#
#!/usr/bin/perl
use strict;
use warnings;
open ONE, $ARGV[0] or die;	#输入SNP文件；
open TWO, $ARGV[1] or die;	#输入gff文件；
my @file = <TWO>;
while(<ONE>){
	chomp;
	my($chr1, $pos, $snp) = (split /\t/, $_)[0,1,2];
	#print "$chr1\n";
	for(@file){
		chomp;
		my($chr2, $start, $end, $strand, $geneMesage) = (split /\t/, $_)[0,3,4,6,8];
	#	print "$chr2\n";		#gff
		if($chr2 eq $chr1){
			if($pos >= $start and $pos <= $end){
				print "$chr1\t$pos\t$snp\t$start\t$end\t$strand\t$geneMesage\n";
			}
		}
	}
}
close ONE;
close TWO;
