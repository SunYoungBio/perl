#!/usr/bin/perl
use strict;
use warnings;


#split rice genome to segments with 100bp
#bed format


#Usage: perl xxx.pl 100
#			SN:Chr10		LN:23207287
#@SQ		SN:Chr11		LN:29021106
#@SQ		SN:Chr12		LN:27531856
#@SQ		SN:Chr1 LN:43270923
#@SQ		SN:Chr2 LN:35937250
#@SQ		SN:Chr3 LN:36413819
#@SQ		SN:Chr4 LN:35502694
#@SQ		SN:Chr5 LN:29958434
#@SQ		SN:Chr6 LN:31248787
#@SQ		SN:Chr7 LN:29697621
#@SQ		SN:Chr8 LN:28443022
#@SQ		SN:Chr9 LN:23012720
#
#

&splitGenome('Chr1',43270923);
&splitGenome('Chr2',35937250);
&splitGenome('Chr3',36413819);
&splitGenome('Chr4',35502694);
&splitGenome('Chr5',29958434);
&splitGenome('Chr6',31248787);
&splitGenome('Chr7',29697621);
&splitGenome('Chr8',28443022);
&splitGenome('Chr9',23012720);
&splitGenome('Chr10',23207287);
&splitGenome('Chr11',29021106);
&splitGenome('Chr12',27531856);


sub splitGenome{
	my ($chr,$lenGeno)=@_;
	my $start = 1;
	my $count = 1;
	while(1){
		my $end	= $start+$ARGV[0]-1;
		if($end > $lenGeno){
			print "$chr\t$start\t$lenGeno\t$count\t\.\t\+\n";
			last;
		}else{
			print "$chr\t$start\t$end\t$count\t\.\t\+\n";
			$count ++;
			$start += $ARGV[0];			
		}

	}
}
