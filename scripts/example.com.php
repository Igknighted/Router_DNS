<?php
// initialize zone data for example.com
$zonedata = array();

// Set an SOA record.
$zonedata['SOA'] = array(
	array(	"ttl" => "300",
		// SOA sepecifics
		// nameserver_hostname postmaster_hostname serial t_refresh t_retry t_expire t_min_ttl
		"content" => "example.com 2008080301 1800 3600 604800 300"),
);

// Set 2 A records.
$zonedata['A'] = array(
	array(	"ttl" => "300",
		"content" => "1.2.3.4"),

	array(	"ttl" => "300",
		"content" => "1.2.3.5"),
);

// Script to decide what the TXT record is based on Geographical Location


/*
 Documentation on this is here: http://php.net/manual/en/function.geoip-record-by-name.php
  $location_info =  array(11) {
  ["continent_code"]=> string(2) "NA"
  ["country_code"]=>   string(2) "US"
  ["country_code3"]=>  string(3) "USA"
  ["country_name"]=>   string(13) "United States"
  ["region"]=>		 string(2) "VA"
  ["city"]=>		   string(14) "Virginia Beach"
  ["postal_code"]=>	string(5) "23454"
  ["latitude"]=>	   float(36.826698303223)
  ["longitude"]=>	  float(-76.01789855957)
  ["dma_code"]=>	   int(544)
  ["area_code"]=>	  int(757)
}*/

if(in_array($location_info["region"], array("VA","NC")) && $location_info["country_code"] == "US"){
	$zonedata['TXT'] = array(
		array(	"ttl" => "300",
			"content" => "\"Hello, this is for a custom region.\""),
		array(	"ttl" => "300",
			"content" => "\"Your IP IS ".$remote_addr."\""),
		array(	"ttl" => "300",
			"content" => "\"".$location_info["region"]." ".$location_info["country_code"]."\""),
	);

}else{
	$zonedata['TXT'] = array(
		array(	"ttl" => "300",
			"content" => "\"Hello ".$remote_addr."\""),
		array(	"ttl" => "300",
			"content" => "\"".$location_info["region"]." ".$location_info["country_code"]."\""),
	);
}
