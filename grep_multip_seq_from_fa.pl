#!/usr/bin/perl
use strict;
use warnings;
#
#Sobic.001G001500.1.p
#============
#>Sobic.001G001500.1.p pacid=28398391 transcript=Sobic.001G001500.1 locus=Sobic.001G001500 ID=Sobic.001G001500.1.v2.1 annot-version=v2.1
#MRPDTRLESAVFQLTPTRTRCDLVVVANGRKEKIASGLLNPFVTHLKVAQEQIAKGGYSITLEPDPEIDVPWFTRGTVER
#FVRFVSTPEVLERVTTIESEILQIEDAIAVQGNDSLGLRYVDDYNGKLVDCMEGSKTSYNPDADRALVPYKAGTQPTPPL
#QNHDATQEENSKAQLIRVLETRKTVLRKEQAMAFARAVAAGFDIDNLVYLITFAERFGASRLMKACTQFIGLWKQKHETG
#QWIEVEPEAMSARSEFPPFNPSGIMFMGDNMKQTMETMSVSNGDANGEDASKVGMF*
#
my @target_seq;
open IN, $ARGV[0] or die;
while(<IN>){
	
	chomp;
	my $name = $_;
	my $file = $ARGV[1];
	my $target_seq = `cat $file | sed -n '/$name/,/^>/{p}' `;
	$target_seq =~ s/\n\>.*//;
	push  @target_seq, $target_seq;
}
print @target_seq;
close IN;

