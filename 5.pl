#!C:\Strawberry\perl\bin\perl

print "Arrays\n";

@testArray = qw/1 23 34 43  23 3 2/;

print "@testArray \n";

foreach (@testArray){
print "$_ ";
}


@copy = @testArray;
$countArray = @copy;


print "\n@copy";
print "\n$countArray";