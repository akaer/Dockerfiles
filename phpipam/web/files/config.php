<?php
$db['host'] = "@@MYSQL_DB_HOSTNAME@@";
$db['user'] = "@@MYSQL_DB_USER@@";
$db['pass'] = "@@MYSQL_DB_PASSWORD@@";
$db['name'] = "@@MYSQL_DB_NAME@@";
$db['port'] = @@MYSQL_DB_PORT@@;

$db['ssl']  = false;
$proxy_enabled  = false;
$debugging  = false;
$phpsessname = "phpipam";
if(!defined('BASE'))
    define('BASE', "/");


?>
