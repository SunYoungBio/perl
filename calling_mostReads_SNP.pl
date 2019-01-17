#calling the most reads SNP which have multipl var;
#4 Chr1	10000005	TL
#34 Chr1	10000005	TN
#38 Chr1	10000005	TE
#30 Chr1	10000005	TV
#32 Chr1	10000005	TG
#311 Chr1	10000005	TA


#!/usr/bin/perl
use strict;
use warnings;
my %hash;
my %hashMAX;
open IN, $ARGV[0] or die $!;		#input counted SNP;
while(<IN>){
	chomp;
	s/^\s+//;
	my @t = split;
	my $readNo = $t[0];
	my $chr=$t[1];
	my $pos=$t[2];
	my $snpDes=$t[3];
	$hash{$chr}{$pos}{$snpDes} = $readNo;			#creat one HASH!
}
close IN;
my %hashDepth;
open IN, $ARGV[1] or die $!;		#input xxx.seqdepth.txt file
while(<IN>){
	chomp;
	my($chr,$pos,$depth) = (split/\t/)[0,1,2];
	$hashDepth{$chr}{$pos}=$depth;
}
close IN;


for my $chr (keys %hash){
	for my $pos (keys %{$hash{$chr}}){
		#my $total = 0;
		my $max = 0;
		for my $snpDes (keys %{$hash{$chr}{$pos}}){
			#$total += $hash{$chr}{$pos}{$snpDes};
			if($max < $hash{$chr}{$pos}{$snpDes}){
				$max = $hash{$chr}{$pos}{$snpDes};
			}
		}
		my $n=0;
		for my $snpDes (keys %{$hash{$chr}{$pos}}){
			if($max == $hash{$chr}{$pos}{$snpDes}){
				$n++;
			}	
		}
		
		if($n==1){
			for my $snpDes (keys %{$hash{$chr}{$pos}}){
				if($max == $hash{$chr}{$pos}{$snpDes}){
				#my $percent = sprintf "%.2f%%",100*($max/$total);
				my $percent = sprintf "%.4f",$max/$hashDepth{$chr}{$pos};
				#$hashMAX{$chr}{$pos}{$snpDes} = "$max\t$hashDepth{$chr}{$pos}\t$percent";	#can sort hashMAX below
				print "$chr\t$pos\t$snpDes\t$max\t$hashDepth{$chr}{$pos}\t$percent\n";
				}	
			}
		}
	}
}
