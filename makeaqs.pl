#!/bin/perl

while(<>) {
	next unless /^2017-/; 
#print "\n-\n";
#print ">$_";
	($d,$l,$c,$awm,$aqd) = split(",");
	next unless $aqd =~ /\d/; 
	print $_;
}
