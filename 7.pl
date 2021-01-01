#!C:\Strawberry\perl\bin\perl

print "push pop shift unshift\n";
print "***********************\n";
@intArray = qw/34  23  22  11 2  44/;

print "@intArray\n";

print "push 55\n";

push(@intArray,55);

print "@intArray\n";


print "push 15\n";

push(@intArray,15);

print "@intArray\n";


print "shift 34\n";

shift(@intArray);

print "@intArray\n";

print "shift 23\n";

shift(@intArray);

print "@intArray\n";

print "unshift 8\n";

unshift(@intArray,8);

print "@intArray\n";


