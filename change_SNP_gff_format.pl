#!/usr/bin/perl
use strict;
use warnings;
#input1.txt
#Chr10	1000097	GT	1000086	1002907	-	ID=LOC_Os10g02620.1;Name=LOC_Os10g02620.1;Parent=LOC_Os10g02620
#Chr10	1000099	GT	1000086	1002907	-	ID=LOC_Os10g02620.1;Name=LOC_Os10g02620.1;Parent=LOC_Os10g02620
#Chr10	10001153	AT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001170	TC	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001209	CT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001228	CT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001247	CT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001252	CT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001261	CA	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001264	CT	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#Chr10	10001275	AG	10001129	10002766	-	ID=LOC_Os10g19940.1;Name=LOC_Os10g19940.1;Parent=LOC_Os10g19940
#input2.txt
##C418	Chr10	10000040	AG	1	69	1.45%	62	62	100%
#C418	Chr10	10000081	GC	1	86	1.16%	65	65	100%
#C418	Chr10	10000107	GA	1	108	0.93%	82	82	100%
#C418	Chr10	10000112	AT	1	115	0.87%	91	91	100%
#C418	Chr10	10000113	AT	1	116	0.86%	92	92	100%
#C418	Chr10	10000126	TC	3	146	2.05%	114	114	100%
#C418	Chr10	1000012	GT	1	68	1.47%	51	51	100%
#C418	Chr10	10000168	AT	1	191	0.52%	179	179	100%
#C418	Chr10	1000016	GA	1	68	1.47%	52	52	100%
#C418	Chr10	10000214	CT	1	195	0.51%	203	203	100%
#

#target:add gene names behind input2;
#usage:perl xxx.pl input1.txt input2.txt > xxx
open ONE, $ARGV[0] or die;	#input input1 file;
open TWO, $ARGV[1] or die;	#input input2 file;
my %hash;
while(<ONE>){
	chomp;
	my($chr, $pos, $SNPdes, $geneMesage) = (split /\t/, $_)[0,1,2,6];
		my $key = $chr.$pos.$SNPdes;
		$hash{$key} = $geneMesage;
	}

close ONE;

while(<TWO>){
	chomp;
	my($chr,$pos,$SNPdes) = (split /\t/)[1,2,3];
	my $key = $chr.$pos.$SNPdes;
	unless(exists$hash{$key}){
		print "$_\tNA\n";
	}else{
		print "$_\t$hash{$key}\n";
	}
}
close TWO;
