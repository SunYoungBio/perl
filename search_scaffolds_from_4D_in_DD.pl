#!/usr/bin/perl
use strict;
use warnings;
#Ϊ��ʵ�֣�4V,4A,4B��reads�д���SNP����������1-7D�Ļ��������mapping��������Ҫȥ������Ⱦɫ���ϵ�scaffolds��ֻ����4D��scaffolds��
#4D��scaffolds��Ⱦɫ���ϵ�λ����֪���������ο���foreachÿһ��Ԫ�أ����ƥ����4V,4A,4B�е�scaffolds��print 4V,4A,4B��SNP��Ϣ��

open IN, "$ARGV[0]" or die "��������ο�scaffolds,$!";
my @Ref_scaffold = <IN>;
close IN;
open IN, "$ARGV[1]" or die "����������Ҫ��ѯ��scaffolds,$!";
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