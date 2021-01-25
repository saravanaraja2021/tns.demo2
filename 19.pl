use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");

$image="largephoto";
$table ="AdventureWorks2019\.production\.Productphoto";
$col = "productphotoid";

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

print $query;


$dbh->do($query);

my $sth1 = $dbh->prepare ("{call usp_ExportImage4(?, ?, ?)}");


$sth1->execute('69','D:\skill tracking\perl\programs\testdir','69');

=cut 

while ( my @row = $sth1->fetchrow_array ) {
      print "@row\n";
}




while ( my @row = $sth->fetchrow_array ) {
      print "@row\n";
}


my $sql = "SELECT o.[name], o.[id], c.[id], c.[name], t.[name]
FROM dbo.syscolumns c
INNER JOIN dbo.sysobjects o
ON c.id = o.id
INNER JOIN dbo.systypes t
ON c.xtype = t.xtype
WHERE c.xtype IN (35, 165, 99, 34, 173)
AND o.[name] NOT LIKE 'sys%'
AND o.[name] <> 'dtproperties'
AND o.xtype = 'U'
";
=
