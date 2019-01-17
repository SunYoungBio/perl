#Chr10	9280425	CT	21	100.00%
#Chr10	28336	TC	13	100.00%
#Chr10	10509230	AT	1	100.00%
#Chr10	2607882	GC	9	100.00%
#Chr10	7431850	TG	1	100.00%
#Chr10	3815020	AG	1	100.00%
#Chr10	16869634	AG	57	100.00%
###########
###########
#Chr10	3927333	AT	16	50.00%
#Chr10	3927333	AC	16	50.00%
###########
#
#!/usr/bin/perl
use strict;
use warnings;
my %snp;
my %read;
open IN,$ARGV[0] or die $!;			#input C418
while(<IN>){
	chomp;
	my @t=split;
	my $chr = $t[0];
	my $pos = $t[1];
	my $snp = $t[2];
	my $read = $t[3];
	my $percent = $t[4];
	my $readmes="$read\t$percent";
	if(exists $snp{$chr}{$pos}){
		my $snpBefor = $snp{$chr}{$pos};
		$snpBefor =~ /(\w)(\w)/;
		my $snp1 = $2;
		$snp =~ /(\w)(\w)/;
		my $snp2 = $2;
		my $snpheter=$snp1.$snp2;
		print "$chr\t$pos\t$snpheter\t$read{$chr}{$pos}{$snpBefor}\t$readmes\n"
	} else {
		$snp{$chr}{$pos}=$snp;
		$read{$chr}{$pos}{$snp}=$readmes;		
	}
}
close IN;
