#!/usr/bin/perl
use v5.10;

$myHash{'key1'} = 5;
$myHash{'key2'} = 3;



$myHashSize = keys %myHash;

if ($myHash{'key1'}) {
	say "True";
	$myHash{'key1'} += 1;
	say $myHash{'key1'};
}
else {
	say "False";
}


say $myHashSize;
