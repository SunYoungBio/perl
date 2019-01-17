#!/usr/bin/perl
use strict;
use warnings;
#input.txt
#W41126	Chr6	1093	AT	1	100.00%	15	1
#W41126	Chr6	1094	AG	1	100.00%	15	1
#W41126	Chr6	1133	TC	1	100.00%	23	1
#W41126	Chr6	1143	AG	1	100.00%	23	1
#W41126	Chr6	1166	AG	1	100.00%	28	1
#W41126	Chr6	1198	CT	1	100.00%	33	1
#W41126	Chr6	1215	GA	1	100.00%	39	3
#W41126	Chr6	1240	TC	1	100.00%	51	9
#C418	Chr6	1246	TC	2	100.00%	50	12
#W41126	Chr6	1254	CT	9	100.00%	48	15
#C418	Chr6	1266	TA	1	100.00%	47	18
#C418_W41126	Chr6	1269	AC	5	100.00%	3	42.86%	47	20
#W41126	Chr6	1270	AG	5	100.00%	47	22

#usage:perl xxx.pl input.txt > output.txt

open IN,$ARGV[0] or die $!;
while(<IN>){
	chomp;
	my @t=split;
	if($t[0] eq 'A'){
		my $percentC=100*(sprintf "%.4f",$t[4]/$t[6]);
		print "$t[0]\t$t[1]\t$t[2]\t$t[3]\t$t[4]\t$t[6]\t$percentC%\t$t[7]\t$t[7]\t100%\n";
	}
	if($t[0] eq 'B'){
		my $percentW=100*(sprintf "%.4f",$t[4]/$t[7]);
		print "$t[0]\t$t[1]\t$t[2]\t$t[3]\t$t[6]\t$t[6]\t100%\t$t[4]\t$t[7]\t$percentW%\n";
	}
	if($t[0] eq 'A_B'){
		my $percentC=100*(sprintf "%.4f",$t[4]/$t[8]);
		my $percentW=100*(sprintf "%.4f",$t[6]/$t[9]);
		print "$t[0]\t$t[1]\t$t[2]\t$t[3]\t$t[4]\t$t[8]\t$percentC%\t$t[6]\t$t[9]\t$percentW%\n";
	}
}
close IN;