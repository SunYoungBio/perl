#!/usr/bin/perl
use strict;
use warnings;


#USAGE:perl xxxx.pl chr_number total_reads read_length > result.txt
#simulate a mass of mapped reads in .bed format
#There are $ARGV[0] chromosomes and $ARGV[1] reads having $ARGV[2] length;
#using perl function 'rand' producing uniformity distribution;

for(my $i=1; $i<$ARGV[1]+1; $i++){
	my $chr = 'Chr'.(int(rand $ARGV[0])+1);
	my $len = $ARGV[2];
	my $pos = int(rand $ARGV[1]);
	my $end = $pos+$len;
	my $str = int(rand 2);
	if($str == 0){
		$str = '+';
	}else{
		$str = '-';
	}
	print "$chr\t$pos\t$end\tread_$i\t255\t$str\n";
}
