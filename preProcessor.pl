#!/bin/perl

my @all_lines, @aqd_lines;

while(<>) {
	next unless /^2017-/; 
	push @all_lines, $_;
	($d,$l,$c,$awm,$aqd) = split(",");
	next unless $aqd =~ /\d/; 
	push @aqd_lines, $_;
}

@all_lines = sort  @all_lines;
@aqd_lines = sort @aqd_lines;

open(my $AQD, ">", "aqs.csv");
open(my $ALL, ">", "all.csv");

print $AQD join("", @aqd_lines);
print $ALL join("", @all_lines);
