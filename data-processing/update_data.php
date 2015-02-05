<?php

$filename="sensor_data.csv";

$content=file_get_contents("https://localdata-sensors.herokuapp.com/api/sources/[Your-ID]/entries?&count=358&sort=desc");
$data=json_decode($content, TRUE);

$handle=fopen($filename, "a");

foreach (range(0, 357) as $number) {
	$timestamp=($data["data"][$number]["timestamp"]);
	$timestamp=substr($timestamp, 0, 10) . " " . substr($timestamp, 11, 8);
	$temperature=($data["data"][$number]["data"]["temperature"]);
	$humidity=($data["data"][$number]["data"]["humidity"]);
	$light=($data["data"][$number]["data"]["light"]);
	$sound=($data["data"][$number]["data"]["sound"]);
	$airquality=($data["data"][$number]["data"]["airquality_raw"]);
	$dust=($data["data"][$number]["data"]["dust"]);
	$uv=($data["data"][$number]["data"]["uv"]);
	$line=array($timestamp, $temperature, $humidity, $light, $sound, $airquality, $dust, $uv);
    fputcsv($handle, $line);
}

fclose($handle);

?>