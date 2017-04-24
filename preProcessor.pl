#!/bin/perl
use feature 'say';

my @all_lines, @aqd_lines;
my $debug = 0;

my $last_flight;

while(<>) {
	next unless /^2017-/; 
	my $isaqd = 1;
	
	
	push @all_lines, $_;
	chop;
	say $_ if $debug;

	($d,$l,$c,$awm,$aqd) = split(",");
	$cur_flight = "$d$l";
	

	say "\taqd: $aqd" if $debug;
	if ($cur_flight eq $last_flight) {
		say "Matching flight. Bonus miles? Not a AQS" if $debug;
		$isaqd = 0;
	}

	unless ($aqd =~ /\d/ || $aqd =~ /Not eligible/) {
		say "AQD isn't a digit. or 'Not eligible', Not a AQS. [$aqd]" if $debug;
		$isaqd = 0;
	}
	push @aqd_lines, "$_\n" if $isaqd;
	$last_flight = $cur_flight;
}

@all_lines = sort  @all_lines;
@aqd_lines = sort @aqd_lines;

open(my $AQD, ">", "aqs.csv");
open(my $ALL, ">", "all.csv");

print $AQD join("", @aqd_lines);
print $ALL join("", @all_lines);
