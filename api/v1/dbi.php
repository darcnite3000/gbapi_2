<?php
include 'NotORM.php';

$username = "promo";
$password = "Pcat19";
$database = "dbPPP";
$host = "localhost";
$dsn = "mysql:dbname=$database;host=$host";
try {
  $connection = new PDO($dsn,$username,$password);
  $structure = new NotORM_Structure_Discovery($connection);
  $cache = null;
  // $cache = new NotORM_Cache_Database($connection);
  // $cache = new NotORM_Cache_File("notorm.dat");
  $gbppp = new NotORM($connection,$structure,$cache);
} catch (Exception $e) {
  echo 'Connection failed: ' . $e->getMessage();
}
