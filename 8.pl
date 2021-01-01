#!C:\Strawberry\perl\bin\perl


@days = qw/mon tue wed thu fri sat sun/;

@weekdays=@days[0..4];
@holidays=@days[5,6];

print "weekdays = @weekdays \n";
print "holidays = @holidays \n";

$daystring=join("-",@days);

print "\$daystring=$daystring\n";

@dayarray = split("-",$daystring);


print "\@dayarray=@dayarray \n";


@joinarray =(@weekdays,@holidays);

print"@joinarray";
