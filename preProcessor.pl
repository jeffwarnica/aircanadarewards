#!/bin/perl
use feature 'say';
use Text::CSV qw( csv );

use Data::Dumper;


my @all_lines, @aqd_lines, @aqs_lines;
my $debug = 0;

my $last_flight;

my %scenerows;
my $csv = Text::CSV->new( { binary => 1, auto_diag =>1, allow_whitespace=>1 } ) or die "Cannot use CSV: " . Text::CSV->error_diag() ;
 
my $BC = "fare option/booking class";

$csv->header( *STDIN );

while( my $row = $csv->getline_hr( *STDIN) ) {
	print Dumper $row if $debug;
	next unless $row->{date} =~ /^2017-/; 
	my $isaqd = 1;
	my $isaqs = 1;

	say $_ if $debug;

	my $thisrow = $row->{date}.$row->{'activity details'};

	say "\taqd: $row->{aqd}" if $debug;
	if (exists($scenerows{$thisrow})) {
		say "Matching flight. Bonus miles? Not a AQS or AQD" if $debug;
		$isaqd = 0; 
		$isaqs = 0;
	}

	unless ($row->{aqd} =~ /\d/ || $row-{aqd} =~ /Not eligible/) {
		say "AQD isn't a digit. or 'Not eligible', Not a AQS or AQD. [$row->{aqd}]" if $debug;
		$isaqd = 0;
		$isaqs = 0;
	}

	unless ($row->{$BC} =~ /\w/) {
		say "Class [" . $row->{$BC} . "] isn't a letter. Some line item for something else? Not an AQS" if $debug;
		$isaqd = 1;
		$isaqs = 0;
	}
	my $line = "\"$row->{date}\",\"$row->{'activity details'}\",\"$row->{$BC}\",\"$row->{aqm}\",\"$row->{aqd}\"";
	push @aqd_lines, $line if $isaqd;
	push @aqs_lines, $line if $isaqs;
	push @all_lines, $line;

	$last_flight = $cur_flight;
	$scenerows{$thisrow}++;
	
}
if ($debug) { 
	print "SCENE ROWS:";
	print Dumper %scenerows;
	print "/\n";
}

print Dumper @aqs_lines if $debug;

@all_lines = sort @all_lines;
@aqd_lines = sort @aqd_lines;
@aqs_lines = sort @aqs_lines;

open(my $AQD, ">", "aqd.csv");
open(my $ALL, ">", "all.csv");
open(my $AQS, ">", "aqs.csv");

print $AQD join("\n", @aqd_lines);
print $ALL join("\n", @all_lines);
print $AQS join("\n", @aqs_lines);

