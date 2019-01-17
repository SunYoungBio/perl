#!/usr/bin/perl
use strict;
use warnings;
#Ŀ�꣺��һ��scaffold.fasta�ļ������д�ϳ�100bp�Ķ����У�
#����һ��������������fasta��ʽ��
#�����и�ʽ��perl split_sequences.pl <�����ļ���ַ>
#�����ļ���
open IN, "$ARGV[0]" || die "can not find the fasta file! $!";
my @data = <IN>;
close IN;
foreach (@data){
	chomp;
	if(/(^>\w+)/){
		print $1,'100',"\n";
	}else{
		my $len = length $_;
		for(my $s=0;$s <= $len; $s += 100){		#����һ������ѭ���и����У�$sΪ���е��и����ʼλ�㣬100Ϊ�и�ȣ�
			if($s<$len-100){
				print $1,$s+100,"\n" if $s != 0;
				my $subseq = substr($_,$s,100);		#ʹ��substr������������Ŀ������@fragments��
				print $subseq,"\n";
			}
		}
	}
}