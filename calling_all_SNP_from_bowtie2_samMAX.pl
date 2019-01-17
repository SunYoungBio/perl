#target:calling ALL SNP from .sam file using bowtie2 tool;
#!/usr/bin/perl
use strict;
use warnings;
open IN,"$ARGV[0]" or die;

while(<IN>){
	s/\n//g;
	if(!/MD:Z:((\d+[ATCGatcg])+)/){
		next;
	}
	my @t=split /\t/;
	my $snp_des=$1;
	my $chr=$t[2];
	my $pos=$t[3];
	my $cigar = $t[5];
	my $seq=$t[9];
	my $len=length$seq;
	if($cigar =~ /I/){
		next;
	}
	my $poffset=0;
	while($snp_des=~/(\d+)([ATCGatcg])/g){
		my $offset=$1;
		my $snpRef=$2;
		$offset=$offset+$poffset;
		my $genomicpos=$pos+$offset;  
		my $snpReads=substr($seq,$offset,1);
		my $des=$snpRef.$snpReads;
		$poffset=$offset+1;
		print "$chr\t\t$genomicpos\t$des\n"
	}
}
close IN;
