#!/usr/bin/perl
use strict;
#use warnings;
#input file format:
#9311_chr01_689551_689600	-	Chr10	7605404	GACTAAGTTATGTGCTTTGGATACATTTTTCGGCATCTCACAATGTTGCC	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	3:C>T,6:C>T
#9311_chr01_752051_752100	+	Chr10	1072210	CTCGTTTGGCTCGCGAGCAGCTCGCGAGCCAGCTCGAGTTGGCTCGTTAT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	18:T>A,38:C>T
#9311_chr01_764251_764300	-	Chr10	9149251	TGCAGTAAAACACTTTGTTACTGTAAAACATATAGATCGTTACTGCACCA	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	
#9311_chr01_808101_808150	+	Chr10	1316360	AGGTGCTGGTTGTTCCCTTTCAGCAAGTGTTGTAGACTCTCATTGGATAT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	16:T>C,39:A>T
#9311_chr01_808151_808200	+	Chr10	1316410	TAGACTCAGGAGCTTCTTTTCATATGACACATGATGTTTCACAGCTTCAG	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	8:A>G,27:G>C
#9311_chr01_958001_958050	+	Chr10	8775294	ACTGAATTTTCCTGCCCCTCGAAGGGTCTTGAAAAATGGCAAGCCCATTT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	38:A>G,46:C>A
#9311_chr01_959101_959150	+	Chr10	8776436	GCATTTTGAGCTTGAGATAATTGTGATGAGAGACTGCTTCGAACTTGGTC	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	4:C>T,16:G>A
#9311_chr01_967201_967250	-	Chr10	5084347	GCTTTGTTTCTGCTGTTATGTGGAGTTATTTAGTGTTTAAAGCCTTTTTC	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	0	5:C>T,44:A>G

open IN, $ARGV[0] or die $!;
my (%hash_9311,%hash_snp,%hash_depth);
while(<IN>){
	chomp;
	my($nine_read, $strand, $Nip_chr,$Nip_pos,$nine_seq,$SNP_infor) = (split /\t/,$_,-1)[0,1,2,3,4,7];		#last k is null perhaps;
	my($nine_name,$nine_chr,$nine_star) = (split /\_/,$nine_read)[0,1,2];
	my $nine_end = $nine_star + (length$nine_seq) - 1;		#in bowtie PE output,reads names have \1 and \2 tails; 
	if($strand eq '+'){
		my $nine_base = $nine_star;
		my $Nip_base = $Nip_pos+1;
		while(1){
			unless(exists $hash_9311{$nine_name}{$nine_chr}{$nine_base}){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "$Nip_chr\t$Nip_base";
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;
			}
			elsif($hash_9311{$nine_name}{$nine_chr}{$nine_base} ne "$Nip_chr\t$Nip_base"){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "#";
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;

			}else{
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;
			}
			$nine_base++;
			$Nip_base++;
			last if $nine_base > $nine_end;	
		}
	}
	elsif($strand eq '-'){
		my $nine_base = $nine_end;
		my $Nip_base = $Nip_pos+1;
		while(1){
			unless(exists $hash_9311{$nine_name}{$nine_chr}{$nine_base}){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "$Nip_chr\t$Nip_base";
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;
			}
			elsif($hash_9311{$nine_name}{$nine_chr}{$nine_base} ne "$Nip_chr\t$Nip_base"){
				$hash_9311{$nine_name}{$nine_chr}{$nine_base} = "#";
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;
				
			}else{
				$hash_depth{$nine_name}{$nine_chr}{$nine_base}++;
			}	
			$nine_base--;
			$Nip_base++;
			last if $nine_base < $nine_star;	
		}

	}
	while($SNP_infor =~ /(\d+):(\w\>\w)/g){
		my $SNP_distance = $1;
		my $SNP = $2;
		my $SNP_pos_nine = $nine_star + $SNP_distance;
		unless(exists $hash_snp{$nine_name}{$nine_chr}{$SNP_pos_nine}){
			$hash_snp{$nine_name}{$nine_chr}{$SNP_pos_nine} = "$SNP\t$strand";
		}
	}
}

#foreach my $nine_name(sort keys %hash_9311){
#	foreach my $nine_chr(sort keys %{$hash_9311{$nine_name}}){
#		foreach my $nine_base(sort {$a<=>$b} keys %{$hash_9311{$nine_name}{$nine_chr}}){
#			unless(exists $hash_snp{$nine_name}{$nine_chr}{$nine_base}){
#				$hash_snp{$nine_name}{$nine_chr}{$nine_base} = ".";
#			}
#			if($hash_9311{$nine_name}{$nine_chr}{$nine_base} ne "#"){
#				print "$nine_name\t$nine_chr\t$nine_base\t$hash_9311{$nine_name}{$nine_chr}{$nine_base}\t$hash_snp{$nine_name}{$nine_chr}{$nine_base}\t$hash_depth{$nine_name}{$nine_chr}{$nine_base}\n";
#			}
#		}
#	}
#}
foreach my $nine_name(keys %hash_9311){
	foreach my $nine_chr(keys %{$hash_9311{$nine_name}}){
		foreach my $nine_base(keys %{$hash_9311{$nine_name}{$nine_chr}}){
			unless(exists $hash_snp{$nine_name}{$nine_chr}{$nine_base}){
				$hash_snp{$nine_name}{$nine_chr}{$nine_base} = "\.\t\.";
			}
			if($hash_9311{$nine_name}{$nine_chr}{$nine_base} eq "#"){
				delete $hash_9311{$nine_name}{$nine_chr}{$nine_base};
				delete $hash_snp{$nine_name}{$nine_chr}{$nine_base};
				delete $hash_depth{$nine_name}{$nine_chr}{$nine_base};
			}else{
				print "$nine_name\_$nine_chr\t$nine_base\t$hash_9311{$nine_name}{$nine_chr}{$nine_base}\t$hash_snp{$nine_name}{$nine_chr}{$nine_base}\t$hash_depth{$nine_name}{$nine_chr}{$nine_base}\n";
				delete $hash_9311{$nine_name}{$nine_chr}{$nine_base};
				delete $hash_snp{$nine_name}{$nine_chr}{$nine_base};
				delete $hash_depth{$nine_name}{$nine_chr}{$nine_base};				
			}
		}
	}
}
close IN;