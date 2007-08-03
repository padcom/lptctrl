<?php

//if (!$fp = fsockopen('padcom.aplaline.com', 8888, $errstr, $errno, 30))
if (!$fp = fsockopen('hryniszak.no-ip.com', 8888, $errstr, $errno, 30))
  trigger_error('Error opening socket', E_USER_ERROR);

$packet = pack("CS", 3, 0);
fwrite($fp, $packet);
$response = fread($fp, 4);
$return = unpack("CCommand/SDataSize/CStatus", $response);
$status = $return["Status"];
fclose($fp);

echo $status;

?>
