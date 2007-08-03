<?php

$bit = $_POST["bit"];
//$bit = $_GET["bit"];

// make connection
//if (!$fp = fsockopen('padcom.aplaline.com', 8888, $errstr, $errno, 30))
if (!$fp = fsockopen('hryniszak.no-ip.com', 8888, $errstr, $errno, 30))
  trigger_error('Error opening socket', E_USER_ERROR);

// request current status
fwrite($fp, pack("CS", 3, 0));
$response = unpack("CCommand/SDataSize/CStatus", fread($fp, 4));

// toggle bit
$status = $response["Status"];
$status ^= (1 << $bit);

// set new status
fwrite($fp, pack("CSC", 4, 1, $status));
$response = unpack("CCommand/SDataSize/CStatus", fread($fp, 4));

// close connection
fclose($fp);

// dump response
echo $response["Status"];

?>
