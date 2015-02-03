<?php

$filename="sensor_data.csv";

$content=file_get_contents("https://localdata-sensors.herokuapp.com/api/sources/[Your-ID]/entries?startIndex=0&count=357&sort=desc");
$data=json_decode($content, TRUE);

$handle=fopen($filename, "a");

$update=array();

foreach (range(0, 356) as $number) {
	$timestamp=($data[$number]["timestamp"]);
	$timestamp=substr($timestamp, 0, 10) . " " . substr($timestamp, 11, 8);
	$temperature=($data[$number]["data"]["temperature"]);
	$humidity=($data[$number]["data"]["humidity"]);
	$light=($data[$number]["data"]["light"]);
	$sound=($data[$number]["data"]["sound"]);
	$airquality=($data[$number]["data"]["airquality_raw"]);
	$dust=($data[$number]["data"]["dust"]);
	$uv=($data[$number]["data"]["uv"]);
	$line=array($timestamp, $temperature, $humidity, $light, $sound, $airquality, $dust, $uv);
    fputcsv($handle, $line);
}

fclose($handle);

?>