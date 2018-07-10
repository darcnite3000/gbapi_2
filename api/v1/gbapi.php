<?php

putenv("TZ=Australia/Sydney");
date_default_timezone_set("Australia/Sydney");

require_once 'GBAPI.class.php';
if(!array_key_exists('HTTP_ORIGIN', $_SERVER)){
  $_SERVER['HTTP_ORIGIN'] = $_SERVER['SERVER_NAME'];
}

try{
  $API = new GBAPI($_REQUEST['request'],$_SERVER['HTTP_ORIGIN']);
  echo $API->processAPI();
}catch(Exception $e){
  echo json_encode(Array('error'=>$e->getMessage()));
}


?>