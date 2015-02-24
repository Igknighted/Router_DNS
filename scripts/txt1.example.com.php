<?php
// initialize zone data for txt1.example.com
// We do not need an SOA in this
$zonedata = array();

// Script to decide what the TXT record is.
if($remote_addr == "127.0.0.1"){
	$zonedata['TXT'] = array(
		array(	"ttl" => "300",
			"content" => "\"Hello Master\""),
	);
}else{
	$zonedata['TXT'] = array(
		array(	"ttl" => "300",
			"content" => "\"Hello World\""),
	);
}
