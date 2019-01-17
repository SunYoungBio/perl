#/usr/bin/perl
use strict;
use warnings;
#Ϊ��ʵ�֣���A genome�е�ȡ4AS��scaffolds���������ƺ����У���
#genome demo��
#>scaffold3889
#ACTATTCATTTCATCAAGCACTTCTTTTTGAGCATTAAGTACTTGTTCTACTTGAGTGGTAACT
#>scaffold5329
#CGGAAATGAATCAACATTCCGGCAAAATATTGGCAACTATCGCATTTCAAATACAGGTACCTGAAAACACAAACATATATGCAACACCACAAACATACATA
#>scaffold4953
#CCTCTACTACATGGTGGAGCATTGGGAGAGGCAACTGTATGGAGGTGGTCAGGAATCTGGGAGACTCACGCCGGTCGTAGCGCCAC
#>scaffold4945
#TTCAAAAAGGAAAGTGAAAGTGAGAAAGACAAGCACTGTTGAAGTGGGAGAGCTCCTTGAACAAAGTTCATGCTCACAGAAACTTTGTGAATCTTAATTACAGAAACTTTTCAATAAAAATAAT
#>Scaffold7161	1073
#GTAGATGGGACTGGCGGATGTCGTTTATTTGCCACTTACATCCCTAGTTTCATCTTACCATTTAATTT

#4AS scaffolds demo��
#>scaffold4945
#>scaffold5329



open IN, "$ARGV[0]" or die "��������Ŀ���ļ�,$!\n";
$/ = "\n";
my @targ_scaffold = <IN>;
close IN;
open IN, "$ARGV[1]" or die "��������Ҫ���ҵ��ļ�,$!\n";
$/ = ">";
my @all_scaffold = <IN>;
shift @all_scaffold;
close IN;

foreach my $targ_scaffold(@targ_scaffold){
	chomp $targ_scaffold;
	foreach my $all_scaffold(@all_scaffold){
		chomp $all_scaffold;
		if($all_scaffold =~ /(\w+\d+)/i){
			my $ID = $1;
			if ($targ_scaffold =~ /$ID\b/i){
				print ">$all_scaffold";
				last;
			}
			
			
		
		}
		
	}
}

