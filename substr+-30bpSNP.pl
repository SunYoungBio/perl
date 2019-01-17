#usr/bin/perl
use strict;
use warnings;
#SNP位点的格式：
#scaffold129945	10804	CT
#D基因组的fa格式：
#>scaffold129945
#ATCGNNNNNNNATCGTGCAGTacgtgca...

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
		if($genome =~ /$t[0]\b/i){
			print "$SNP_inf";
			if($genome =~ /\n([ATCGN]+)/i){
				my $upseq = substr ($1,$t[1]-31,30) ;
				my $downseq = substr ($1,$t[1],30);
				print "$upseq\[$ref_snp\/$ali_snp\]$downseq\n";
				last;
			}
		}
	}
}


