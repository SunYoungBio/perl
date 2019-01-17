#!/usr/bin/perl
use strict;
use warnings;
#确定fseq的peaks在基因组上的分布，利用gff文件。

open IN, $ARGV[0] or die;	#输入fseq的peaks bed结果文件，bed文件起始位点为0
my @file1 = <IN>;
close IN;
open IN, $ARGV[1] or die;	#输入gff文件
my @file2 = <IN>;
close IN;
my @file3;
foreach my $line1 (@file1){
	my($chr1, $start1, $end1) = (split /\t/, $line1)[0,1,2];	#fseq生成bed文件
	foreach my $line2 (@file2){
		my($chr2, $start2, $end2, $strand) = (split /\t/, $line2)[0,3,4,6];	#gff
		next if $chr1 ne $chr2;
		if($strand =~ /\+/){
			if (($start1+1 >= $start2-1000 and $start1+1 <= $end2) or ($end1+1 >= $start2-1000 and $end1+1 <= $end2) or ($start1+1 <= $start2-1000 and $end1+1 >= $end2)){
			push @file3, $line1;
			last;
			}
		}
		elsif($strand =~ /\-/){
			if (($start1+1 >= $start2 and $start1+1 <= $end2+1000) or ($end1+1 >= $start2 and $end1+1 <= $end2+1000) or ($start1+1 <= $start2 and $end1+1 >= $end2+1000)){
			push @file3, $line1;
			last;
			}
		}
	}
}
print @file3;	#输出与gff的mRNA以及TSS上游1000bp有overlap的peaks