#!/usr/bin/perl
use v5.10;



sub main {
	$hold = "#";

	#opens tcpdump100.log file into array @lines
	my $IPLogs = 'tcpdump100.log';
	open(FILE, "<", $IPLogs) or die "Can't open $IPLogs";
	my @lines = <FILE>;
	close(FILE);

	
	$IP6_connections = 0; #sets counter for IP6 connections

	for(@lines) {
		if($_ =~ /IP6 (([0-9a-f]*:){5}[0-9a-f]+).*>/) { #if a line has an IP6 conenction
			
			$IP6_connections += 1;

			# stores line in myVar, cuts beginning and end off line to preserve only the IP6 number itself
			$myVar = $&;
			for (1..2) { chop($myVar); }
			my $revMyVar = reverse $myVar;
			for(1..4) { chop($revMyVar); }
			my $myVar = reverse $revMyVar;
			say $myVar;
			
			# if item exists as key in hash, increase the content by 1
			# otherwise, make item key in hash and set value to 1
			if ($IP6_hash{$myVar}) { $IP6_hash{$myVar} += 1; }
			else { $IP6_hash{$myVar} = 1; }
		}
	}

	
	# gets size of hash
	$IP6_hash_size = keys %IP6_hash;

	say "There are ", $IP6_connections, " total IPv6 Connections!";
	say "There are ", $IP6_hash_size, " unique IPv6 Connections!";


	$MAC_addresses = 0;
        for(@lines) {
                if($_ =~ /(([0-9a-fA-F]*:){5}[0-9a-fA-F]+@)/) {

                        $MAC_addresses += 1;

                        $MAC = $&;
                        my $revMAC = reverse $MAC;
                        chop($revMAC);
                        my $MAC = reverse $revMAC;
                        say $MAC;

                        if ($MAC_hash{$MAC}) { $MAC_hash{$MAC} += 1; }
                        else { $MAC_hash{$MAC} = 1; }
                }
        }

	$MAC_hash_size = keys %MAC_hash;
	say "There are ", $MAC_addresses, " total MAC addresses!";
	say "There are ", $MAC_hash_size, " unique MAC addresses!";


	#say "Machine count: " . $hold . "\n";

	#say "Connections: " . $hold;
	#say "Connections cont.: one line per machine. <tab><count><tab><Unique Mac Address>";
}



# (([0-9a-fA-F]{0,2}:){5}[0-9a-fA-F]{0,2})
#
# one IP to another IP is a connection!
# even same Ip works!


main();

