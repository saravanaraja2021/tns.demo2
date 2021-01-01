#!C:\Strawberry\perl\bin\perl


print "enter first number\n";
$first=<STDIN>;

print "enter second number\n";
$second=<STDIN>;

sub add{
	$sum=0;
	foreach $i (@_){
		$sum=$sum+$i;
	}	
	print "$sum ";
}

sub mul{
	$sum=1;
	foreach $i (@_){
		$sum=$sum*$i;
	}	
	print "$sum ";
}

add($first,$second);
mul($first,$second);




