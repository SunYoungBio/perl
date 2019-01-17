#!/usr/bin/perl
use strict;
use warnings;
open IN, $ARGV[0] or die;
my @fregment;
my @length;
while(<IN>){
	chomp;
	@length = split /\t/, $_;
for(my $n = 0; $n <= $#length-2;$n++){
	my $m = $n+1;
	my $fregment = $length[$m] - $length[$n];
		push @fregment, "$fregment\t";
}		
push @fregment, "$length[$#length]\t";

}

close IN;
	
@fregment = sort{$a<=>$b} @fregment;

print @fregment;
