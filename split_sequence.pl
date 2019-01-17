#!/usr/bin/perl
use strict;
use warnings;
#目标：将一个scaffold.fasta文件内序列打断成100bp的短序列；
#并给一个序列名，做成fasta格式；
#命令行格式：perl split_sequences.pl <输入文件地址>
#输入文件：
open IN, "$ARGV[0]" || die "can not find the fasta file! $!";
my @data = <IN>;
close IN;
foreach (@data){
	chomp;
	if(/(^>\w+)/){
		print $1,'100',"\n";
	}else{
		my $len = length $_;
		for(my $s=0;$s <= $len; $s += 100){		#设置一个变量循环切割序列，$s为序列的切割的起始位点，100为切割长度；
			if($s<$len-100){
				print $1,$s+100,"\n" if $s != 0;
				my $subseq = substr($_,$s,100);		#使用substr函数，创建新目标数组@fragments；
				print $subseq,"\n";
			}
		}
	}
}