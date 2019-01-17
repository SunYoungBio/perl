#!/usr/bin/perl
use strict;
use warnings;


#[yangyang@manager annotation]$ awk '$3~/gene/{print}' Sbicolor_255_v2.1.gene.gff3 | more 
#Chr01   phytozomev10    gene    1619    2809    .       +       .       ID=Sobic.001G000100.v2.1;Name=Sobic.001G000100
#Chr01   phytozomev10    gene    11116   14952   .       -       .       ID=Sobic.001G000200.v2.1;Name=Sobic.001G000200
#Chr01   phytozomev10    gene    22401   24208   .       -       .       ID=Sobic.001G000300.v2.1;Name=Sobic.001G000300
#Chr01   phytozomev10    gene    24318   42528   .       -       .       ID=Sobic.001G000400.v2.1;Name=Sobic.001G000400
#Chr01   phytozomev10    gene    50024   50488   .       -       .       ID=Sobic.001G000500.v2.1;Name=Sobic.001G000500
#======
#[yangyang@manager annotation]$ head Sobic_WRKY_only_name.txt 
#Sobic.002G174300
#Sobic.004G065900
#Sobic.003G296300
#Sobic.003G337500
#Sobic.002G168300
#Sobic.003G285500
#Sobic.003G341100
#Sobic.010G045700
#Sobic.010G209200
#Sobic.003G000600
#

my %hash;
open IN, $ARGV[0] or die;	#input gff3 file;
while(<IN>){
	chomp;
	my($message) = (split /\t/, $_)[-1];
	my($name) = (split /=/, $message)[-1];
	$hash{$name} = $_;
}
close IN;

open IN, $ARGV[1] or die;	#input genes file;
while(<IN>){
	chomp;
	print "$hash{$_}\t$_\n" if exists $hash{$_};
}
close IN;

