use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");

$padd="person\.Address";

$query = <<"EOF";
create or alter procedure spSelectAddressByCity 
\@city nvarchar(100)
as
begin


select addressline1 from $padd where city=\@city 

end
EOF


$dbh->do(q/ "$query" /);

my $sth1 = $dbh->prepare ("{call spSelectAddressByCity (?)}");


$sth1->execute('Oxon');

while ( my @row = $sth1->fetchrow_array ) {
      print "@row\n";
}


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
