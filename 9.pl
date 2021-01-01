#!C:\Strawberry\perl\bin\perl

print "Hashes \n";
print "****** \n";

%address = ('raja','chennai','babu','madurai','karthick','ramnad');

$address{'ram'}="trichy";

print "before del\n";
foreach (keys%address){
print "$_ ";
}

print "\n";

delete $address{'ram'};
print "after del\n";
foreach (keys%address){
print "$_ ";
}

