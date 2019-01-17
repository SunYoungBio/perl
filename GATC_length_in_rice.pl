#!/usr/bin/perl
use strict;
use warnings;
open IN, $ARGV[0] or die;
my @length;
my @fregment;
my $length;
while(<IN>){
	chomp;
	next if /^\>/;
	my $seq = $_;
	my $total_length = length $_;
	#push @length, "0";
	for(my $pos = 0; $pos <= $total_length-3; $pos++){
		$pos = index($seq, "GATC", $pos);
		last if $pos == -1;
		$length = $pos + 2;
		push @length, "$length\t";
	}
	my $last_length = $total_length - $length;
	push @length, "$last_length\n";
}
close IN;


print @length;
