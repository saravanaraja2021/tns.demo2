use DBI;
my $user = 'sa';
my $password = 'sa';
my $dbsource = 'adventureworks2019';

#my $dbh = DBI->connect("dbi:ODBC:Driver={};Server=192.168.3.137;UID=$user;PWD=$password")

my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server Native Client 11.0};Server=localhost;Database=$dbsource;UID=$user;PWD=$password");


$dbh->do(q/CREATE TABLE PERL_SAMPLE_TABLE (i INTEGER)/);


# This procedure takes one input parameter and two output parameters.
# The procedure inserts the input parameter value into a test table.
# The output parameters are used to return the number of rows affected
# by each INSERT statement.
$dbh->do(q/CREATE PROCEDURE PROC_INSERT_TABLES (@inputval int,
                                                @rowcount1 int OUTPUT,
                                                @rowcount2 int OUTPUT) AS
    BEGIN

    -- SET NOCOUNT ON here will prevent DBI rows from returning
    -- the row count.

    INSERT INTO PERL_SAMPLE_TABLE VALUES (@inputval);

    -- @@ROWCOUNT returns the number of rows affected by the
    -- last statement. Store this number in the first output
    -- parameter.

      SET @rowcount1 = @@ROWCOUNT;
        INSERT INTO PERL_SAMPLE_TABLE VALUES (@inputval + 1);
      SET @rowcount2 = @@ROWCOUNT;
    END/);


# The first placeholder (?) in this prepared statement represents
# the value that's supplied as the procedure's input parameter.
# The second and third placeholders are used to capture the
# procedure's output parameter values.

my $sth1 = $dbh->prepare ("{call PROC_INSERT_TABLES(?, ?, ?)}");

my $i = 1;
my $sqlserverrowcount;
my $sqlserverrowcount2;


# Bind value for the first placeholder (the procedure's input parameter).
$sth1->bind_param(1, $i);


# $sqlserverrowcount and $sqlserverrowcount2 store the row count
# values returned by the procedure's output parameters.
$sth1->bind_param_inout(2, \$sqlserverrowcount, 1);
$sth1->bind_param_inout(3, \$sqlserverrowcount2, 1);


# Execute the prepared statement.
$sth1->execute();

# Produce a cumulative total for the number of rows affected
# by both INSERT statements.
$sqlserverrowcount = $sqlserverrowcount + $sqlserverrowcount2;

print "Rows affected (Cumulative \@ROWCOUNT) = $sqlserverrowcount\n";


# The rows method returns the number of rows affected by the last
# row affecting statement. It's unaware that the procedure contained
# more than one INSERT statement.
print "Rows affected (DBI rows method) = ", $sth1->rows, "\n";

$dbh->do(q/DROP PROCEDURE PROC_INSERT_TABLES/);
$dbh->do(q/DROP TABLE PERL_SAMPLE_TABLE/);

$dbh->disconnect;
