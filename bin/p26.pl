#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_recurring_cycle_size_of_fraction);

=pod
A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

1/2=    0.5
1/3=    0.(3)
1/4=    0.25
1/5=    0.2
1/6=    0.1(6)
1/7=    0.(142857)
1/8=    0.125
1/9=    0.(1)
1/10=   0.1
Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
=cut

my $solution;
my $max_size = 0;
my $optimal_d; # optimal denominator to produce largest recurring cycle
my $MAX_DENOM = $ARGV[0] || 1000;

for(my $k = 2; $k < $MAX_DENOM; $k++)
{
    my $cycle_size = get_recurring_cycle_size_of_fraction(1, $k);
    # say "$k => $cycle_size";
    if($cycle_size > $max_size)
    {
        $max_size = $cycle_size;
        $optimal_d = $k;
    }
}

$solution = $optimal_d;

say "Solution = $solution" if $solution; # 983

