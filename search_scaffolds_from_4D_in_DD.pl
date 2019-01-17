#!/usr/bin/perl
use strict;
use warnings;
#为了实现：4V,4A,4B的reads中存在SNP，由于是与1-7D的基因组进行mapping，所以需要去除其他染色体上的scaffolds，只保留4D的scaffolds；
#4D的scaffolds在染色体上的位置已知，以其作参考，foreach每一个元素，如果匹配上4V,4A,4B中的scaffolds就print 4V,4A,4B的SNP信息；

open IN, "$ARGV[0]" or die "请先输入参考scaffolds,$!";
my @Ref_scaffold = <IN>;
close IN;
open IN, "$ARGV[1]" or die "请先输入需要查询的scaffolds,$!";
my @Que_scaffold = <IN>;
close IN;

foreach my $Ref_scaffold(@Ref_scaffold){
	chomp $Ref_scaffold;
	foreach my $Que_scaffold(@Que_scaffold){
		if ($Que_scaffold =~ /$Ref_scaffold/ig){
			print $Que_scaffold;
		}
	}
}