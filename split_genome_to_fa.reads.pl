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
		for(my $s=0;$s < $len; $s += $tar_len){			#����һ������ѭ���и����У�$sΪ���е��и����ʼλ�㣬$tar_lenΪ�и�ȣ�
			if($s<=$len-$tar_len){
					my $star_pos = $s+1;
					my $end_pos = $s+$tar_len;
					push @array1, "$ID\_$star_pos\_$end_pos\n";
					my $subseq = substr($seq,$s,$tar_len);			#ʹ��substr������������Ŀ������@fragments��
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