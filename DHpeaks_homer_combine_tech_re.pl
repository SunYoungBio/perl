#!/usr/bin/perl
use strict;
use warnings;
#将两次技术重复数据合并去并集。

open IN, $ARGV[0] or die;
my @file1 = <IN>;
close IN;
open IN, $ARGV[1] or die;
my @file2 = <IN>;
close IN;
my @file3;
foreach my $line1 (@file1){
	push @file3, $line1;
	next if $line1 =~ /^#/;
	my($chr1, $start1, $end1) = (split /\t/, $line1)[1,2,3];
	foreach my $line2 (@file2){
		next if $line2 =~ /^#/;
		my($chr2, $start2, $end2) = (split /\t/, $line2)[1,2,3];
		next if $chr1 ne $chr2;
		if (($start1 >= $start2 and $start1 <= $end2) or ($end1 >= $start2 and $end1 <= $end2) or ($start1 <= $start2 and $end1 >= $end2)){
		pop @file3;
		last;
		}
	}
}
push @file3, @file2;
print @file3;