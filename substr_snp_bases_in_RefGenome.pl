#usr/bin/perl
use strict;
use warnings;
#SNP position:
#id1000001       Chr1    14147
#id1000027       Chr1    173923
#id1000051       Chr1    200011
#id1000220       Chr1    422263
#K_id1000223     Chr1    423620
#id1000256       Chr1    482261
#

#target: conf the ref.genome bases

#constructure the genome hash
my %hash;
open IN,$ARGV[0] or die;
$/=">";
while(<IN>){
	next if $_ =~ /^\>$/;
	chomp;
	my @chr_seq = split /\n/, $_;
	$hash{$chr_seq[0]}=$chr_seq[1];
}

$/="\n";
open IN,$ARGV[1] or die;
while(<IN>){
	chomp;
	my @snp_message = split /\t/, $_;
	if(exists $hash{$snp_message[1]}){
		my $ref_snp = substr ($hash{$snp_message[1]},$snp_message[2]-1,1);
		print "$_\t$ref_snp\n";
	}
}