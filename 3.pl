#!C:\Strawberry\perl\bin\perl

# no type declaration in perl
# dynamically typed language



$counter =1;

do 
{
print "enter first number\n";

while (($num1 = <STDIN>) =~ "[a-z]"){
   print "enter valid number\n";
}

print "enter second number\n";
while (($num2 = <STDIN>) =~ "[a-z]"){
   print "enter valid number\n";
}


$add=$num1 + $num2 ;
$sub =$num1 - $num2 ;
$mul =$num1 * $num2 ;
$div = $num1 / $num2 ;

print "addition = $add\nsubtraction = $sub\nmulti = $mul\ndivision = $div\n";

$counter++;

} while ($counter <=5)



