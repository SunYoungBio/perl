#/usr/bin/perl
use strict;
use warnings;
#为了实现：从A genome中调取4AS的scaffolds（包括名称和序列）；
#genome demo：
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

#4AS scaffolds demo：
#>scaffold4945
#>scaffold5329



open IN, "$ARGV[0]" or die "请先输入目标文件,$!\n";
$/ = "\n";
my @targ_scaffold = <IN>;
close IN;
open IN, "$ARGV[1]" or die "请输入需要查找的文件,$!\n";
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

