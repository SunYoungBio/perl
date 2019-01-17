#origin reads snp message：
#[yangyang@node009 fseq_t6]$ head nipX9311_peaks_include_snp_percent.txt 
#Chr10   27823   27875   Chr10.3 0.10974782      27832   GT      1       Chr10   27832   29      0.0344828
#Chr10   27823   27875   Chr10.3 0.10974782      27847   GC      1       Chr10   27847   83      0.0120482
#Chr10   27823   27875   Chr10.3 0.10974782      27851   GT      15      Chr10   27851   86      0.174419
#Chr10   27823   27875   Chr10.3 0.10974782      27874   GT      1       Chr10   27874   15      0.0666667
#Chr10   45310   45570   Chr10.5 0.115314215     45338   AG      16      Chr10   45338   42      0.380952
#Chr10   45310   45570   Chr10.5 0.115314215     45353   AG      2       Chr10   45353   41      0.0487805
#Chr10   45310   45570   Chr10.5 0.115314215     45378   AT      11      Chr10   45378   33      0.333333
#Chr10   45310   45570   Chr10.5 0.115314215     45407   AG      1       Chr10   45407   17      0.0588235
#Chr10   45310   45570   Chr10.5 0.115314215     45425   GA      10      Chr10   45425   24      0.416667
#Chr10   45310   45570   Chr10.5 0.115314215     45448   GC      1       Chr10   45448   27      0.037037



#9311nip snp message：
#[yangyang@node009 fseq_t6]$ head nipX9311_peaks_include_9311nip.snp.txt 
#Chr10   45310   45570   Chr10.5 0.115314215     45338   AG
#Chr10   45310   45570   Chr10.5 0.115314215     45378   AT
#Chr10   45310   45570   Chr10.5 0.115314215     45425   GA
#Chr10   45310   45570   Chr10.5 0.115314215     45504   CT
#Chr10   45310   45570   Chr10.5 0.115314215     45515   AG
#Chr10   57351   57485   Chr10.12        0.11804472      57359   TG
#Chr10   58095   58532   Chr10.14        0.31013107      58174   TA
#Chr10   58095   58532   Chr10.14        0.31013107      58175   TA
#Chr10   58095   58532   Chr10.14        0.31013107      58469   GT
#Chr10   58095   58532   Chr10.14        0.31013107      58481   GA
#
#

#!/usr/bin/perl
use strict;
use warnings;
my %hash;

open IN, $ARGV[0] or die;	#input snp_percents.txt
while(<IN>){
	chomp;
	my @t = split;
	my $key = "$t[0]\t$t[1]\t$t[2]\t$t[3]\t$t[4]\t$t[5]\t$t[6]";
	$hash{$key} = "$t[7]\t$t[10]\t$t[11]";
}
close IN;

open IN, $ARGV[1] or die;	#input 9311nip_snp.txt
while(<IN>){
	chomp;
	if (exists $hash{$_}){
		print "$_\t$hash{$_}\n";
	}else{
		print "$_\t\#\t\#\t\#\n";
	}
}