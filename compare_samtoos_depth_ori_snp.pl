#[yangyang@node009 fseq_t6]$ cut -f 11-13 nipX9311_peaks_include_9311nip.snp_percent100nip.txt | head
#Chr10   58174   37
#Chr10   58175   36
#Chr10   58469   112
#Chr10   58528   8
#Chr10   82324   86
#Chr10   89133   38
#Chr10   94158   79
#Chr10   95678   9
#Chr10   102676  19
#Chr10   102792  47
#[yangyang@node009 fseq_t6]$ head nipX9311_peaks_include_9311nip.snp_percent100nip.txt 
#Chr10   58095   58532   Chr10.14        0.31013107      58174   TA      #       #       #
#Chr10   58095   58532   Chr10.14        0.31013107      58175   TA      #       #       #
#Chr10   58095   58532   Chr10.14        0.31013107      58469   GT      #       #       # 
#Chr10   58095   58532   Chr10.14        0.31013107      58528   CT      #       #       #      
#Chr10   82051   82974   Chr10.32        0.42187876      82324   CT      #       #       #      
#Chr10   88999   89145   Chr10.42        0.13581799      89133   TC      #       #       #       
#Chr10   94131   94496   Chr10.48        0.25243944      94158   GC      #       #       #       
#Chr10   95678   97043   Chr10.50        0.21539193      95678   CG      #       #       #       
#Chr10   102404  102884  Chr10.58        0.14795654      102676  TC      #       #       #      
#Chr10   102404  102884  Chr10.58        0.14795654      102792  TG      #       #       #      

#

#!/usr/bin/perl
use strict;
use warnings;
my %hash;

open IN, $ARGV[0] or die;	#input samtool_depth_snp.txt
while(<IN>){
	chomp;
	next if $_ ~~ /^\s*$/;
	my @t = split;
	my $key = "$t[0]\t$t[1]";
	$hash{$key} = $t[2];
}
close IN;

open IN, $ARGV[1] or die;	#input ori_snp.txt
while(<IN>){
	chomp;
	my @T = split;
	my $Key = "$T[0]\t$T[5]";
	if (exists $hash{$Key}){
		print "$T[0]\t$T[1]\t$T[2]\t$T[3]\t$T[4]\t$T[5]\t$T[6]\t$hash{$Key}\n";
	}else{
		print "$T[0]\t$T[1]\t$T[2]\t$T[3]\t$T[4]\t$T[5]\t$T[6]\t8000\n";
	}
}