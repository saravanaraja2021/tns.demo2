#comments

sub capitalize{
	@myStr = @_;
	$str = $myStr[0];
	return "\u$str";
}



$str = "i am an ironman";

print capitalize($str);