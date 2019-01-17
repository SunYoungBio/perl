#!/usr/bin/perl
use strict;
use warnings;
#Ŀ�꣺��9311.fa���ļ����д�ϳ�$tar_len bp�Ķ����У�
#����һ��������������fasta��ʽ��
#�����и�ʽ��perl split_sequences.pl <�����ļ���ַ>

open IN, $ARGV[0] || die "can not find the fasta file! $!";			#�����ļ���
my @data = <IN>;
close IN;
my $tar_len = $ARGV[1];			#����Ҫ�и�ĳ��ȣ�

foreach (@data){
	chomp;
	if(/(^>\w+)/){
		my $ID = $1;
	}else{
		my $ID = $1;
		my $seq = $_;
		my $len = length $seq;
		for(my $s=0;$s <= $len-$tar_len; $s++){			#����һ������ѭ���и����У�$sΪ���е��и����ʼλ�㣬����Ϊ1��$s++����
					my $star_pos = $s+1;
					my $end_pos = $s+$tar_len;
					print "$ID\_$star_pos\_$end_pos\n";
					my $subseq = substr($seq,$s,$tar_len);			#ʹ��substr������������Ŀ������@fragments��
					print "$subseq\n";
			}
		}
	}
	