#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Calendar qw(get_next_date get_date_string SUNDAY MONDAY);

=pod
Counting Sundays
You are given the following information, but you may prefer to do some research for yourself.

1 Jan 1900 was a Monday.
Thirty days has September,
April, June and November.
All the rest have thirty-one,
Saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.
A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
=cut

my $solution;

my @date = (1900, 1, 1, MONDAY); # start with given date
my $sunday_count = 0;

while($date[0] <= 2000)
{
    @date = get_next_date(@date);
    # say get_date_string(@date);
    if($date[0] > 1900 && $date[0] <= 2000 &&
        $date[2] == 1 &&
        $date[3] == SUNDAY) {
        $sunday_count++;
    }
}

$solution = $sunday_count;

say "Solution = $solution" if $solution; # 171 



