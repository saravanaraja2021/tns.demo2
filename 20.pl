use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");


$sth= $dbh->prepare("SELECT  it.TABLE_SCHEMA + '\.'+  o.name as tbl,  
c.[name] as imgcolumn,i.column_name as colmnid
FROM dbo.syscolumns c
INNER JOIN dbo.sysobjects o
ON c.id = o.id
INNER JOIN dbo.systypes t
ON c.xtype = t.xtype
INNER JOIN INFORMATION_SCHEMA.COLUMNS i
on o.name = i.table_name
inner join INFORMATION_SCHEMA.TABLES it
on it.TABLE_NAME = i.TABLE_NAME
WHERE c.xtype IN (35, 165, 99, 34, 173)
AND o.[name] NOT LIKE 'sys%'
AND o.[name] <> 'dtproperties'
AND o.xtype = 'U'
and i.ORDINAL_POSITION=1
and o.name != 'Document'
");

$sth->execute();

#$sth->finish();


while ( my @row = $sth->fetchrow_array){
	push(@copy,@row);
#	myfun ($row[2], $row[3], $row[4] );

}

$sth->finish();

#print "@copy";

myfun(@copy);


sub myfun{


$index = 0;
my $arrSize = scalar @_;

      while ( $index < $arrSize ){
  
	
	$table =$_[$index];
	$image=$_[++$index];
	$col = $_[++$index];

	print "$table $image $col \n";
        print "_________________________\n";

	

$sth1= $dbh->prepare("SELECT $col from $table ");
$sth1->execute();

@imgrowcp = ();

while ( my @imgrow = $sth1->fetchrow_array){
     push(@imgrowcp, @imgrow);
      
}
$sth1->finish();

$query = <<"EOF";
CREATE or alter PROCEDURE usp_ExportImage4 (
   \@PicName NVARCHAR (100)
   ,\@ImageFolderPath NVARCHAR(1000)
   ,\@Filename NVARCHAR(1000)
   )
AS
BEGIN
   DECLARE \@ImageData VARBINARY (max);
   DECLARE \@Path2OutFile NVARCHAR (2000);
   DECLARE \@Obj INT
 
   SET NOCOUNT ON
 
   SELECT \@ImageData = (
         SELECT convert (VARBINARY (max), $image, 1)
         FROM $table
         WHERE $col = \@PicName
         );
 
   SET \@Path2OutFile = CONCAT (
         \@ImageFolderPath
         ,'\\'
         , \@Filename
         );
    BEGIN TRY
     EXEC sp_OACreate 'ADODB.Stream' ,\@Obj OUTPUT;
     EXEC sp_OASetProperty \@Obj ,'Type',1;
     EXEC sp_OAMethod \@Obj,'Open';
     EXEC sp_OAMethod \@Obj,'Write', NULL, \@ImageData;
     EXEC sp_OAMethod \@Obj,'SaveToFile', NULL, \@Path2OutFile, 2;
     EXEC sp_OAMethod \@Obj,'Close';
     EXEC sp_OADestroy \@Obj;
    END TRY
    
 BEGIN CATCH
  EXEC sp_OADestroy \@Obj;
 END CATCH
 
   SET NOCOUNT OFF
END
EOF

#print $query;



$dbh->do($query);

my $sth2 = $dbh->prepare ("{call usp_ExportImage4(?, ?, ?)}");

 

chdir('D:\skill tracking\perl\programs\testdir');
system("md $table.$image");

foreach $c_img (@imgrowcp){
       $sth2 -> execute($c_img,"D:\\skill tracking\\perl\\programs\\testdir\\$table.$image",$c_img); 

}

$index++;

#$dbh->do($query);

#my $sth1 = $dbh->prepare ("{call usp_ExportImage4(?, ?, ?)}");


}
	
}




