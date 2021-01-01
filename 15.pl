sub add{

 $total=0;
 
 foreach $i (@_){
   $total += $i;
 }

 print "total is $total";

}


@mylist = (1,2,3,4,5,6,7);

#add(4,7,@mylist); 

%myhash = { 'name' => 'saravna', 'age' => 20 } ;

print " %myhash ";

#values % myhash   
