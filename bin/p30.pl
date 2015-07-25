#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_digits sum_of_array); 

=pod
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4
As 1 = 1^4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
=cut

my $solution;

my $MIN = 2;
my $MAX = 1_000_000;
my $POWER = 5;

my @list = (); # list of numbers that are sum of the powers of their digits

for(my $k = $MIN; $k < $MAX; $k++)
{
    my $digits = get_digits($k);
    my $sum = get_sum_of_powers($digits, $POWER);
    if($sum == $k)
    {
        push(@list, $k);
    }
}

$solution = sum_of_array(@list);
say "Solution = $solution" if $solution; #443839

sub get_sum_of_powers
{
    my ($list, $power) = @_;
    my $sum = 0;
    foreach my $element (@$list)
    {
        $sum += ($element ** $power);
    }
    return $sum;
}


