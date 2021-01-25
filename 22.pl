use DBI;
#use strict;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';


@driver_names = DBI->available_drivers;
%drivers      = DBI->installed_drivers;



my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");


my $sth= $dbh->prepare("select  it.table_schema + '.'+  o.name as tbl,  
	c.[name] as imgcolumn,i.column_name as colmnid
	from dbo.syscolumns c
	inner join dbo.sysobjects o
	on c.id = o.id
	inner join dbo.systypes t
	on c.xtype = t.xtype
	inner join information_schema.columns i
	on o.name = i.table_name
	inner join information_schema.tables it
	on it.table_name = i.table_name
	where c.xtype in (35, 165, 99, 34, 173)
	and o.[name] not like 'sys%'
	and o.[name] <> 'dtproperties'
	and o.xtype = 'u'
	and i.ordinal_position=1
	and o.name != 'document'	
	");

$sth->execute();

my @tableDet;

while ( my @row = $sth->fetchrow_array){
	push(@tableDet,@row);
}

$sth->finish();

#print  @tableDet;
exportImageProc(@tableDet);


sub exportImageProc{

	my $index = 0;
	my $arrSize = scalar @_;

	
        while ( $index < $arrSize ){
  
		my $table =$_[$index];
		my $image=$_[++$index];
		my $col = $_[++$index];
	
        
		my $sth1= $dbh->prepare("SELECT $col from $table ");
		$sth1->execute();

		my @imgrowcp = ();

		while ( my @imgrow = $sth1->fetchrow_array){
     			push(@imgrowcp, @imgrow);
      		}
		$sth1->finish();

        		
		my $query = <<"EOF";
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

	$dbh->do($query);

	my $sth2 = $dbh->prepare ("{call usp_ExportImage4(?, ?, ?)}");

 

	chdir('D:\skill tracking\perl\programs\testdir');
	system("md $table.$image");

	foreach my $c_img (@imgrowcp){
	        $sth2 -> execute($c_img,"D:\\skill tracking\\perl\\programs\\testdir\\$table.$image",$c_img); 
	}

	$index++;

	}
}




