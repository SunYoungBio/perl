open IN,"$ARGV[0]" or die;
while(<IN>){
	s/\n//g;
	my @t=split /\t/;
	if(!/MD:Z:(\w+)/){
		next;
	}
	my $snp_des=$1;
	my $chr=$t[2];
	my $pos=$t[3];
	my $seq=$t[9];
	#my $poffset=0;
	while($snp_des=~/(\d+)([ATCGatcg])/g){
		my $offset=$1;
		my $snpRef=$2;
		my $genomicpos=$pos+$offset;  #$offset=$offset+$poffset;
		my $snpReads=substr($seq,$offset,1);
		next if $snpReads eq "N";
		my $des=$snpRef.$snpReads;
		next if $allsnp{$chr}{$genomicpos}==-1;
		if($allsnp{$chr}{$genomicpos}!~/\w/){
			$allsnp{$chr}{$genomicpos}=$des;
		}else{
			$allsnp{$chr}{$genomicpos}=-1 if $allsnp{$chr}{$genomicpos} ne $des;
		}
		# $poffset=$offset+1;
	}
}
close IN;

foreach my $chr (keys %allsnp){
	foreach my $pos (keys %{$allsnp{$chr}}){
		print "$chr\t$pos\t$allsnp{$chr}{$pos}\n";
	}
}
			
		
		
