#!C:\Strawberry\perl\bin\perl

print "references \n";
print "***********\n";

$myInt = 10;
$myIntRef = \$myInt ;

@myArray = qw/2 33 4 25 55/;
$myArrayRef = \@myArray;


%myData = ('key1' => 10, 'key2' => 20);
$myDataRef = \%myData;


print "$$myIntRef\n";
print "@$myArrayRef\n";
print "%$myDataRef";
