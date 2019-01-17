#usr/bin/perl
use strict;
use warnings;
#SNPλ��ĸ�ʽ��
#scaffold129945	10804	CT
#D�������fa��ʽ��
#>scaffold129945
#ATCGNNNNNNNATCGTGCAGTacgtgca...
#�޸��˲���ƥ���ģʽ��������������ʽ������ʼ��if($genome =~ /\n([ATCGN]+)/i){...}����line28��my @r = split /\s+/, $genome;

open IN, "$ARGV[0]" or die "can open the SNP file!$!";
my @SNP_inf = <IN>;
close IN;
open IN, "$ARGV[1]" or die "can open the genome file!$!";
$/ = ">";
my @genome = <IN>;
close IN;

foreach my $SNP_inf (@SNP_inf){
	my @t = split /\t/,$SNP_inf;
	next if $t[1] < 31;
	my $ref_snp = substr ($t[2],0,1);
	my $ali_snp = substr ($t[2],1,1);
	foreach my $genome (@genome){
		chomp $genome;
		if($genome =~ /$t[0]\b/i){
			print "$SNP_inf";
			my @r = split /\s+/, $genome;
			my $upseq = substr ($r[-1],$t[1]-31,30) ;
			my $downseq = substr ($r[-1],$t[1],30);
			print "$upseq$ali_snp$downseq\n";
			last;
		}
	}
}


