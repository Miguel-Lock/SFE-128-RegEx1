#!/usr/bin/perl
use v3.10;

my $filename = 'testtext.txt';
open(FILE, "<", $filename) or die "Can't open $filename"; #opens file
my @lines = <FILE>; #reads each line from FILE into array
close(FILE); #closes FILE


for(@lines) {
	print $_; #prints line one by one
}


print $#lines # note that this is index, meaning result + 1 = total array values
