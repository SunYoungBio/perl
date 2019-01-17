#!/usr/bin/perl -w

#file_peaks_from_fseq&homer.bed
#Chr10   46638   46970   Chr10.8 0.15764777
#Chr10   57841   58561   Chr10.21        0.6605057
#Chr10   58895   58980   Chr10.22        0.112629816
#Chr10   59559   59658   Chr10.23        0.098166354
#Chr10   66734   67439   Chr10.27        0.53031635
#Chr10   67775   68256   Chr10.29        0.13805461
#Chr10   68426   68915   Chr10.30        0.43272436
#Chr10   80996   81261   Chr10.43        0.11580676
#Chr10   82032   83033   Chr10.47        0.89170086
#Chr10   88946   89159   Chr10.55        0.16543077
#

#usage:perl xxx.pl file1_peaks_from_fseq&homer.bed file2_peaks_from_fseq&homer.bed file3_peaks_from_fseq&homer.bed file4_peaks_from_fseq&homer.bed > 4_samples_compared_results.txt


my %hash0;
my %hash1;
my %hash2;
my %hash3;

open IN0, $ARGV[0] or die;
while(<IN0>){
	chomp;
	$hash0{$_} = "A";
}
close IN0;

open IN1, $ARGV[1] or die;
while(<IN1>){
	chomp;
	if(exists $hash0{$_}){
		$hash0{$_} = "$hash0{$_}B";
	}else{
		$hash1{$_} = "B";
	}
}
close IN1;

open IN2, $ARGV[2] or die;
while(<IN2>){
	chomp;
	if(exists $hash0{$_}){
		$hash0{$_} = "$hash0{$_}C";
	}
	elsif(exists $hash1{$_}){
		$hash1{$_} = "$hash1{$_}C";
	}else{
		$hash2{$_} = "C";
	}
}
close IN2;

open IN3, $ARGV[3] or die;
while(<IN3>){
	chomp;
	if(exists $hash0{$_}){
		$hash0{$_} = "$hash0{$_}D";
	}
	elsif(exists $hash1{$_}){
		$hash1{$_} = "$hash1{$_}D";
	}
	elsif(exists $hash2{$_}){
		$hash2{$_} = "$hash2{$_}D";
	}else{
		$hash3{$_} = "D";
	}
}
close IN3;

foreach(sort keys %hash0){
	print "$_\t$hash0{$_}\n";
}

foreach(sort keys %hash1){
	print "$_\t$hash1{$_}\n";
}

foreach(sort keys %hash2){
	print "$_\t$hash2{$_}\n";
}

foreach(sort keys %hash3){
	print "$_\t$hash3{$_}\n";
}
