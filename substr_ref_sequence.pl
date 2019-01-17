
#!/usr/bin/perl
use strict;
use warnings;


#substr($string, $inistall_position, $length)
#
#[yangyang@node009 zhaohongwei]$ head Total_nucleic_acid_05172017_blastn_1k_plus_non_overlap_CDS.bed 
#Chr1    77924   80039   ath-MIRf10000-npr       .       +
#Chr1    162609  165107  NONATHG000006.1 .       +
#Chr1    162609  165107  NONATHT000006   .       +
#Chr1    163225  165576  NONATHG000004.1 .       +
#Chr1    163225  165576  NONATHT000004   .       +
#Chr1    164445  167239  NONATHG000005.1 .       +
#Chr1    164445  167239  NONATHT000005   .       +
#Chr1    614878  616972  ath-MIRf10638-npr       .       +
#Chr1    665118  667367  NONATHG000015.1 .       +
#Chr1    665118  667367  NONATHT000015   .       +
#============================
#Chr02   phytozomev10    gene    55196695        55198785        .       +       .       ID=Sobic.002G174300.v2.1;Name=Sobic.002G174300  Sobic.002G174300
#Chr04   phytozomev10    gene    5372334 5374163 .       +       .       ID=Sobic.004G065900.v2.1;Name=Sobic.004G065900  Sobic.004G065900
#Chr03   phytozomev10    gene    62858027        62860152        .       -       .       ID=Sobic.003G296300.v2.1;Name=Sobic.003G296300  Sobic.003G296300
#Chr03   phytozomev10    gene    66078929        66086450        .       +       .       ID=Sobic.003G337500.v2.1;Name=Sobic.003G337500  Sobic.003G337500
#Chr02   phytozomev10    gene    52695615        52704484        .       -       .       ID=Sobic.002G168300.v2.1;Name=Sobic.002G168300  Sobic.002G168300
#Chr03   phytozomev10    gene    61903430        61905669        .       -       .       ID=Sobic.003G285500.v2.1;Name=Sobic.003G285500  Sobic.003G285500
#Chr03   phytozomev10    gene    66414558        66417445        .       +       .       ID=Sobic.003G341100.v2.1;Name=Sobic.003G341100  Sobic.003G341100
#Chr10   phytozomev10    gene    3570459 3574991 .       +       .       ID=Sobic.010G045700.v2.1;Name=Sobic.010G045700  Sobic.010G045700
#Chr10   phytozomev10    gene    55014274        55016269        .       -       .       ID=Sobic.010G209200.v2.1;Name=Sobic.010G209200  Sobic.010G209200
#Chr03   phytozomev10    gene    65796   68547   .       -       .       ID=Sobic.003G000600.v2.1;Name=Sobic.003G000600  Sobic.003G000600
#
my %hash;

$/ = ">";
open IN, $ARGV[0] or die $!;	#input genome file
while(<IN>){
	chomp;
	my @t = split /\n/;
	$hash{$t[0]}=$t[1];
}


$/ = "\n";
open IN, $ARGV[1] or die $!;	#input bed file
while(<IN>){
	chomp;
	my @t = split;
	if (exists $hash{$t[0]}){
		#my $target_seq = substr ($hash{$t[0]}, $t[1]-1, $t[2]-$t[1]+1);		#IF input .bed file
		my $target_seq = substr ($hash{$t[0]}, $t[3]-1, $t[4]-$t[3]+1);		#IF input .gff3 file
		print "\>$t[9]_$t[0]_$t[3]_$t[4]\t$t[6]\n$target_seq\n";
	}
}










