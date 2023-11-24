---
title: "PHP Integration With Databases"
---

PHP can access the SGDB of the database and make SQL queries. PHP, like operating systems (windows with .dll and linux based with .so files), have extensions. An example of PHP extensions are the SGDB drivers.

## PDO Class

### PDO Available Drivers

| Driver | Supported SGBD
|--------|---------------
| PDO_CUBRID | Cubrid
| PDO_DBLIB | FreeTDS / Microsoft SQL Server / Sybase
| PDO_FIREBIRD | Firebird
| PDO_IBM | IBM DB2
| PDO_INFORMIX | IBM Informix Dynamic Server
| PDO_MYSQL | MySQL 3.x/4.x/5.x
| PDO_OCI | Oracle Call Interface
| PDO_ODBC | ODBC v3 (IBM DB2, unixODBC e win32 ODBC)
| PDO_PGSQL | PostgreSQL
| PDO_SQLITE | SQLite 3 e SQLite 2
| PDO_SQLSRV | Microsoft SQL Server / SQL Azure
| PDO_4D | 4D

The connection is made like this (only changing database name for the one you want to use): `$dsn = new PDO("mysql:host=localhost;dbname=test", $user, $pass);`

### Exceptions in PHP

Use `try` `catch` blocks.

### EXEC Method

This method, belonging to the PDO Class, executes an SQL statement and returns the number of rows affected by the statement. Syntax is:

```php
$affectedLinesQuantity = $dsn->exec("Delete From Client Where client_code = 1");
echo "Affected lines: " . $affectedLinesQuantity
```

### Query Method

The Query method, also belonging to the PDO Class, has a function similar to the Exec method. However, in addition to executing an SQL statement, it returns – when available – a set of results (result set) as a PDOStatement object. In case of failures, the boolean FALSE is returned.

```php
$SQLInstruction = "Select name, code, phone From Client";
$resultSet = $dsn->query($sql);
while ($row = $resultSet->fetch()) {
  echo $row['name'] . "\t";
  echo $row['code'] . "\t";
  echo $row['code'] . "\n";
}
```

### Prepare and Execute Methods

1. Define constants and create connection:

```php
define('HOST', '127.0.0.1');
define('PORT', '5432');
define('DBNAME', 'test');
define('USER', 'user');
define('PASSWORD', 'passwd');

try {
  $dsn = new PDO("mysql:host=". HOST . ";port=".PORT.";dbname=" . DBNAME .";user=" . USER . ";password=" . PASSWORD);
} catch (PDOException $e) {
  echo 'The connection failed and I return the following error message: ' .$e->getMessage();
}
```

2. Performing a DB query through the login and password received by POST:

```php
$login = $_POST['login'];
$userPasswd = $_POST['passwd'];

$stmt = $dsn->prepare("Select * From User Where login = :login And password =:password");
$stmt->execute([':login' => $login, ':password' => $userPasswd]);

// or

$stmt = $dsn->prepare("Select * From User Where login = ? And password = ?");
$stmt->execute([$login, $userPasswd]);
```

3. Destroying the statement object and closing the connection:

```php
$stmt = null;
$dsn = null;
```

# Footer

- **Class**: Web Development
- **Theme**: PHP Integration With Databases