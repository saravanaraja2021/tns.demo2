$server = "localhost"; 

`bcp AdventureWorks2019.HumanResources.EmployeePayHistory out D:\\testdata3.dat -c -t, -S localhost -T`;

#`bcp "SELECT cast(ThumbNailPhoto as varchar(8000)) from Production.ProductPhoto where productphotoid=80" queryout d:\\test89 -d Adventureworks2019  -c -T`;

#`bcp "SELECT cast(ThumbNailPhoto as varbinary(max)) from Production.ProductPhoto where productphotoid=80" queryout d:\\test89 -d Adventureworks2019  -c -T`;


#`bcp "SELECT cast(document as varchar(8000)) from Production.document where documentnode=0x6AC0" queryout d:\\testdir\\test01.doc -d Adventureworks2019  -c -T`;

`bcp "SELECT convert(VARBINARY (max), img, 1) from Production.myimages where id=1" queryout d:\\testdir\\test44.jpg -d Adventureworks2019  -c -T`;

print $?	