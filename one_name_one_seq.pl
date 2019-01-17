#!/usr/bin/perl
use strict;
use warnings;
open IN, "$ARGV[0]" || die "can not find the fasta file! $!";
my @data = <IN>;
close IN;
push @data, ">\n";
my $seq ='';
foreach (@data){
	s/\r\n//;
	if(/^>/){
			print "$seq\n" if $seq ne '';
		$seq = '';
		if(/>\S/){
			print "$_\n";
		}
	}
	elsif(/^\w/){
		$seq .= $_;
	}
}
