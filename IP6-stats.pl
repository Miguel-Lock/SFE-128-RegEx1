#!/usr/bin/perl
use v5.10;



sub main {
	$hold = "#";

	my $IPLogs = 'tcpdump100.log';
	open(FILE, "<", $IPLogs) or die "Can't open $IPLogs";
	my @lines = <FILE>;
	close(FILE);

	for(@lines) {
		print($_ "\n\n");
	}
	
	$IP6_connections = 0;

	for(@lines) {
		if($_ =~ /IP6 (([0-9a-f]*:){5}[0-9a-f]+).*>/) {
			$IP6_connections += 1;
			$myVar = $&;
			for (1..2) { chop($myVar); }
			my $revMyVar = reverse $myVar;

			for(1..4) { chop($revMyVar); }

			my $myVar = reverse $revMyVar;

			say $myVar;
		
			if ($IP6_hash{$myVar}) { $IP6_hash{$myVar} += 1; }
			else { $IP6_hash{$myVar} = 1; }
		}
	}

	

	$IP6_hash_size = keys %IP6_hash;
	say "There are ", $IP6_connections, " total IPv6 Connections!";
	say "There are ", $IP6_hash_size, " unique IPv6 Connections!";

	# make hash. Add items. Default value is 0. Update vale to += 1 if more.


	#say "IP6 Connections: " . $hold . "\n";

	#say "Machine count: " . $hold . "\n";

	#say "Connections: " . $hold;
	#say "Connections cont.: one line per machine. <tab><count><tab><Unique Mac Address>";
}





main();

