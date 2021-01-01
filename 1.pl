$dir = "d:\*";


@myfiles=glob($dir);

foreach (@myfiles){
	print "$_"."\n";
}