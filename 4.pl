#!C:\Strawberry\perl\bin\perl


$test = 10;

$multiline =<<EOF;

this is a multil line
\nthis is a multil line
\uthis is a multil line
\Uthis is a multil line
this is a multil line
variable test=$test
EOF


print $multiline;



