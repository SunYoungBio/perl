#!/usr/bin/perl
use strict;
use warnings;

my(%hash9311);
open IN, $ARGV[0] or die $!;	#
while(<IN>){
	chomp;
	my @t = split /\t/;
	my $key = $t[0];
	$hash9311{$key}=$_;
}
close IN;

open IN, $ARGV[1] or die $!;	#
while(<IN>){
	chomp;
	my @t = split /\t/;
	if(exists $hash9311{$t[0]}){
		print "$hash9311{$t[0]}\n"}
}
close IN;












