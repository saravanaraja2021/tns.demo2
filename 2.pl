use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");


$mypic = "testpic100.jpg";

my $sql = "exec dbo.usp_ExportImage ?,?,? ";

my $sth = $dbh->prepare($sql);

$sth->execute( '1', "d:\\testdir", $mypic );


 

#$sth->execute($sql);

print $?;

=cut
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
