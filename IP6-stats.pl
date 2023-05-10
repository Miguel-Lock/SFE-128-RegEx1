#!/usr/bin/perl
use v5.10;

#Miguel Lock
#SFE-128-A
#RegEx1

sub countIP6 {
	my @lines = @{$_[0]};

	$IP6_connections = 0;
	for(@lines) {
		#if a line has an IP6 conenction
		if($_ =~ /IP6 (([0-9a-f]*:){5}[0-9a-f]+).*>/) {
			$IP6_connections += 1;

			# stores line in myVar, cuts beginning and end off line to preserve only the IP6 number itself
			$myVar = $&;
			for (1..2) { chop($myVar); }
			my $revMyVar = reverse $myVar;
			for(1..4) { chop($revMyVar); }
			my $myVar = reverse $revMyVar;
			
			# if item exists as key in hash, increase the content by 1
			if (exists($IP6_hash{$myVar})) { $IP6_hash{$myVar} += 1; }
			# otherwise, make item key in hash and set value to 1
			else { $IP6_hash{$myVar} = 1; }
		}
	}
	$IP6_hash_size = keys %IP6_hash;

	#edits $totalIP6, $uniqueIP6 (passed by reference)
	$_[1] = $IP6_connections;
	$_[2] = $IP6_hash_size;
}


sub countMAC {
	my @lines = @{$_[0]};

	$MAC_addresses = 0;
    for(@lines) {
		#if a line has a MAC address
        if($_ =~ /(([0-9a-fA-F]{0,2}:){5}[0-9a-fA-F]{0,2})/ ) {
            $MAC_addresses += 1;

            if ($MAC_hash{$&}) { $MAC_hash{$&} += 1; }
            else { $MAC_hash{$&} = 1; }
            }
        }

	$MAC_hash_size = keys %MAC_hash;

	#edits $totalAddresses, $uniqueAddresses (passed by reference)
	$_[1] = $MAC_addresses;
	$_[2] = $MAC_hash_size;
}


sub countConnections {
	my @lines = @{$_[0]};

	$connections = 0;
	for(@lines) {
		#if there are IP addresses on both sides of the carrot
		if($_ =~ /(IP.*>\ (([0-9a-fA-F]{0,4}:){5}[0-9a-fA-F]))|(IP.*>\ ff02::[0-9a-fA-F])|(IP.*>\ (([0-9]{1,3}+.){3}[0-9]{0,3}))/ ) {
			$connections += 1;
		}
	}

	#edits $totalConnections (passed by reference)
	$_[1] = $connections;
}


sub main {
	#opens tcpdump100.log file into array @lines
	$IPLogs = 'tcpdump100.log';
	open(FILE, "<", $IPLogs) or die "Can't open $IPLogs";
	my @lines = <FILE>;
	close(FILE);
	
	#counts and displays total and unique number of IPv6 addresses
	$totalIP6 = 0; $uniqueIP6 = 0;
	&countIP6(\@lines, $totalIP6, $uniqueIP6);
	say "There are ", $totalIP6, " total IPv6 addresses!";
	say "There are ", $uniqueIP6, " unique IPv6 addresses!\n";

	#counts and displays total number and unique number of MAC addresses
	$totalAddresses = 0; $uniqueAddresses = 0;
	&countMAC(\@lines, $totalAddresses, $uniqueAddresses);
	say "There are ", $totalAddresses, " total MAC addresses!";
	say "There are ", $uniqueAddresses, " unique MAC addresses!\n";

	#counts and displays total connections
	$totalConnections = 0;
	&countConnections(\@lines, $totalConnections);
	say "There are ", $totalConnections, " total connections!";
}

main();
