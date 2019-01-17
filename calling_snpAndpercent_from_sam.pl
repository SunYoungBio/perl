#Input SAM files from bowtie or bowtie2 to call SNP and its reads number;
#Demand the reads that have SNP excluding INDEL;

#!/usr/bin/perl
use strict;
use warnings;
open IN,"< $ARGV[0]" or die;
my $inputfile = $ARGV[0];
my %hash;
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
	next unless $cigar =~ /$len/ ;	#exclude having INDEL reads
	my $poffset=0;
	while($snp_des=~/(\d+)([ATCGatcg])/g){
		my $offset=$1;
		my $snpRef=$2;
		$offset=$offset+$poffset;
		my $genomicpos=$pos+$offset;  
		my $snpReads=substr($seq,$offset,1);
		$poffset=$offset+1;
		next if $snpReads eq "N";
		my $des=$snpRef.$snpReads;
		
		#print "$chr\t$genomicpos\t$des\n";
		unless(exists $hash{$chr}{$genomicpos}){
			$hash{$chr}{$genomicpos}{$des}=1;
		}else{
			$hash{$chr}{$genomicpos}{$des}++;
		}
	}
}
close IN;
#=======================================
#input samtools depth file

my %hashC;
open IN, $ARGV[1] or die $!;		#input A.seqdepth.txt file
while(<IN>){
	chomp;
	my($Chr,$Pos,$Depth) = (split/\t/)[0,1,2];
	$hashC{$Chr}{$Pos}=$Depth;
}

(my $filename = $inputfile) ~~ s/\.sam//;
my $outfile = $filename.'_all_SNP.txt';
open OUT, "> $outfile" or die;
foreach my $chr(sort keys %hash){
	foreach my $genomicpos(sort{a<=>b} keys %{$hash{$chr}}){
		foreach my $des(sort keys %{$hash{$chr}{$genomicpos}}){
			unless(exists $hashC{$chr}{$pos}){
			$hashC{$chr}{$pos}='NA';
			print OUT "$chr\t$genomicpos\t$des\t$hash{$chr}{$genomicpos}{$des}\t$hashC{$chr}{$pos}\t'NA'\n";
			next;
			}else{
				my $percent=100*(sprintf "%.4f",$hash{$chr}{$genomicpos}{$des}]/$hashC{$chr}{$pos});
				print OUT "$chr\t$genomicpos\t$des\t$hash{$chr}{$genomicpos}{$des}\t$hashC{$chr}{$pos}\t$percent\n";					
			}
		
		}
	}
}
close OUT;
