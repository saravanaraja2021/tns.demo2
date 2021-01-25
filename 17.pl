use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");

$dbh->do(q/CREATE or alter PROCEDURE usp_ExportImage5 (
   @PicName NVARCHAR (100)
   ,@ImageFolderPath NVARCHAR(1000)
   ,@Filename NVARCHAR(1000)
   )
AS
BEGIN
   DECLARE @ImageData VARBINARY (max);
   DECLARE @Path2OutFile NVARCHAR (2000);
   DECLARE @Obj INT
 
   SET NOCOUNT ON

   SELECT @ImageData = (
         SELECT convert (VARBINARY (max), img, 1)
         FROM AdventureWorks2019.Production.myimages
         WHERE id = @PicName
         );
 
   SET @Path2OutFile = CONCAT (
         @ImageFolderPath
         ,'\'
         , @Filename
         );
    BEGIN TRY
     EXEC sp_OACreate 'ADODB.Stream' ,@Obj OUTPUT;
     EXEC sp_OASetProperty @Obj ,'Type',1;
     EXEC sp_OAMethod @Obj,'Open';
     EXEC sp_OAMethod @Obj,'Write', NULL, @ImageData;
     EXEC sp_OAMethod @Obj,'SaveToFile', NULL, @Path2OutFile, 2;
     EXEC sp_OAMethod @Obj,'Close';
     EXEC sp_OADestroy @Obj;
    END TRY
    
 BEGIN CATCH
  EXEC sp_OADestroy @Obj;
 END CATCH
 
   SET NOCOUNT OFF
END/);


$sth= $dbh->prepare("select productphotoid from Production.ProductPhoto");

$sth->execute();


@copy = ""; 

while ( my @row = $sth->fetchrow_array){

push(@copy,@row);

}


$sth->finish();

foreach $myrow (@copy){

my $sth1 = $dbh->prepare ("{call usp_ExportImage3(?, ?, ?)}");

$sth1 -> execute($myrow,'D:\skill tracking\perl\programs\testdir',$myrow.test); 

}