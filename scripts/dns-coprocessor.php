#!/usr/bin/php
<?php
$helo = fgets(STDIN);
if($helo != "HELO\t3\n"){
		echo "FAIL\n";		
		exit;
}

echo "OK\t";
echo "PHPBackend Firing Up\n";


while($f = fgets(STDIN)){
		$f = explode("\t", $f, 8);
		$type = $f[0];
		$qname = $f[1];
		$qclass = $f[2];
		$qtype = $f[3];
		$id = $f[4];
		$remote_addr = $f[5];
		$local_addr = $f[6];
		$edns_subnet_addr = $f[7];

		$bits = 21;
		$auth = 1;

		$zone_file = "/etc/powerdns/php-zones/$qname.php";

		file_put_contents("/tmp/dns_php1_$qname.$qtype", "Qtype $qtype");
		if(file_exists($zone_file)){
				// location info needs to be available before we include the zone data
				$location_info = geoip_record_by_name($remote_addr);

				// get the zone variable data
				include($zone_file);

				// qname			 qclass	qtype	 ttl id	content
				//if(($qtype == "SOA" || $qtype == "ANY") && $qname == "example.com"){
				if($qtype == "ANY"){
						foreach($zonedata as $type => $records){
								foreach($zonedata[$type] as $record){
										$zone_out = "DATA\t";
										$zone_out .= "$bits\t";
										$zone_out .= "$auth\t";
										$zone_out .= "$qname\t";
										$zone_out .= "$qclass\t";
										$zone_out .= "$type\t";
										$zone_out .= $record['ttl']."\t";
										$zone_out .= "1\t";
										$zone_out .= $record['content']."\n";
				
										echo $zone_out;
										file_put_contents("/tmp/dns_php2_$qname.$qtype", "Ranthis: ".$zone_out);
								} // foreach 
						} // foreach
				}else if(count($zonedata[$qtype]) > 0){ 

						foreach($zonedata[$qtype] as $record){
								$zone_out = "DATA\t";
								$zone_out .= "$bits\t";
								$zone_out .= "$auth\t";
								$zone_out .= "$qname\t";
								$zone_out .= "$qclass\t";
								$zone_out .= "$qtype\t";
								$zone_out .= $record['ttl']."\t";
								$zone_out .= "1\t";
								$zone_out .= $record['content']."\n";

								echo $zone_out;
								file_put_contents("/tmp/dns_php2_$qname.$qtype", "Ranthis: ".$zone_out);
						} // foreach
				} // else
		}
		echo "END\n";
}
