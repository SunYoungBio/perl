#!/usr/bin/perl
use strict;
use warnings;
#目标：将9311.fa的文件序列打断成$tar_len bp的短序列；
#并给一个序列名，做成fasta格式；
#命令行格式：perl split_sequences.pl <输入文件地址>

open IN, $ARGV[0] || die "can not find the fasta file! $!";			#输入文件：
my @data = <IN>;
close IN;
my $tar_len = $ARGV[1];			#输入要切割的长度；

my @array1;
my @array2;
my $ID;
foreach (@data){
	chomp;
	if(/(^>\w+)/){
		my $ID = $1;
	}else{
		my $ID = $1;
		my $seq = $_;
		my $len = length $seq;
		for(my $s=0;$s < $len; $s += $tar_len){			#设置一个变量循环切割序列，$s为序列的切割的起始位点，$tar_len为切割长度；
			if($s<=$len-$tar_len){
					my $star_pos = $s+1;
					my $end_pos = $s+$tar_len;
					push @array1, "$ID\_$star_pos\_$end_pos\n";
					my $subseq = substr($seq,$s,$tar_len);			#使用substr函数，创建新目标数组@fragments；
					push @array1, "$subseq\n";
				} else {
					my $subseq = substr($seq,$s);
					my $last_len = length $subseq;
					my $star_pos = $s+1;
					my $end_pos = $s+$last_len;
					push @array1, "$ID\_$star_pos\_$end_pos\n";
					push @array1, "$subseq\n";
				}
			}
		}
	}
print @array1;