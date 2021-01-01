=thiis
#single line comment

$myscalar=20;

$multiline='this is multi line comment
comment
dfdf
=========== $myscalar
';


print $multiline ;##




$myint = 10;
$myfloat =20.3;
$mystring = "raja";

print "$myint $myfloat $mystring" ;


@myarray = (1,2,4,5);

print "$myarray[3]";


%myaddress = ( 'raja' ,  45);

print $myaddress{'raja'};



@arrayint = (2,4,5,6,4,5);

$size=@arrayint;
@copy =@arrayint;
#print "size $size , @copy";


push(@copy,"end of array");

print "@copy\n";

shift(@copy);
print "later \n";
print "@copy";

splice(@copy,3,10,1..10);
print ("@copy");





%nameage = (-raja,20,-kayal,4,-kamalesh,-8);

print "$nameage{'-raja'}";


@names = keys%nameage;
@age = values%nameage;
print "@age";

=cut


$i=306;
$j=100;


unless ( $i > $j ){
	print "$i is not greater than $j";
}
else{
	print "$i is greater";
}





