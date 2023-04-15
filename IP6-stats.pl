#!/usr/bin/perl
use v5.10;

sub countIP6 {
	my @lines = @{$_[0]};

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
			
			# if item exists as key in hash, increase the content by 1
			# otherwise, make item key in hash and set value to 1
			if ($IP6_hash{$myVar}) { $IP6_hash{$myVar} += 1; }
			else { $IP6_hash{$myVar} = 1; }
		}
	}

	# gets size of hash
	$IP6_hash_size = keys %IP6_hash;

	say "There are ", $IP6_connections, " total IPv6 Connections!";
	say "There are ", $IP6_hash_size, " unique IPv6 Connections!\n";
}

sub countMAC {
	my @lines = @{$_[0]};

	$MAC_addresses = 0; #sets counter for MAC addresses
        for(@lines) {
                if($_ =~ /(([0-9a-fA-F]{0,2}:){5}[0-9a-fA-F]{0,2})/ ) { #if a line has a MAC address

                        $MAC_addresses += 1;

                        if ($MAC_hash{$&}) { $MAC_hash{$&} += 1; }
                        else { $MAC_hash{$&} = 1; }
                }
        }

	$MAC_hash_size = keys %MAC_hash; #gets size of hash

	say "There are ", $MAC_addresses, " total MAC addresses!";
	say "There are ", $MAC_hash_size, " unique MAC addresses!\n";
}

sub countConnections {
	my @lines = @{$_[0]};

	$connections = 0; #sets counter for connections
	for(@lines) {
		if($_ =~ /(IP.*>\ (([0-9a-fA-F]{0,4}:){5}[0-9a-fA-F]))|(IP.*>\ ff02::[0-9a-fA-F])|(IP.*>\ (([0-9]{1,3}+.){3}[0-9]{0,3}))/ ) { #if IP addresses exist on left and right sides of carrot
			$connections += 1;
		}
	}

	say "There are ", $connections, " total connections!";
}


sub main {
	$hold = "#";

	#opens tcpdump100.log file into array @lines
	my $IPLogs = 'tcpdump100.log';
	open(FILE, "<", $IPLogs) or die "Can't open $IPLogs";
	my @lines = <FILE>;
	close(FILE);
	
	#calls subroutine countIP6
	&countIP6(\@lines);

	#calls subroutine countMAC
	&countMAC(\@lines);

	#calls subroutine countConnections
	&countConnections(\@lines);


}


main();

