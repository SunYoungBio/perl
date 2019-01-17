#!/usr/bin/perl
use strict;
use warnings;

#Chr10   57346   57538   Chr10.14        0.11741371      1989    1651
#Chr10   57857   58040   Chr10.15        0.1235855       1798    1666
#Chr10   66639   66705   Chr10.19        0.11392397      922     716
#Chr10   67590   67702   Chr10.21        0.10666252      952     962
#Chr10   71685   71837   Chr10.28        0.11519864      1540    1357
#Chr10   72259   72365   Chr10.30        0.10757708      1072    1054
#Chr10   81689   81774   Chr10.35        0.12438627      991     1098
#Chr10   81842   81907   Chr10.36        0.1231623       1042    797
#Chr10   101642  101846  Chr10.59        0.12663175      1993    1995
#Chr10   104519  104605  Chr10.66        0.13292058      869     1177
#


open IN, $ARGV[0] or die;
#(my $filename = $ARGV[0]) =~ s/\_.*//;
while(<IN>){
	chomp;
	my @t = split;
	my $peak_length_K = ($t[2]-$t[1]+1)/1000;
	my $mapped_reads1_M = ($ARGV[1])/1000000;
	my $mapped_reads2_M = ($ARGV[2])/1000000;
	
	my $RPKM1 = $t[-2]/($mapped_reads1_M*$peak_length_K);
	my $RPKM2 = $t[-1]/($mapped_reads2_M*$peak_length_K);
	my $FPKM = ($RPKM1+$RPKM2)/2;
	
	print "$_\t$RPKM1\t$RPKM2\t$FPKM\n";
}


