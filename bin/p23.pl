#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_divisors sum_of_array);

=pod
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
=cut

use constant NON_ABUNDANT_UPPER_LIMIT => 28123; # or at least the one that's known

my $solution = 0;

## find all abundant numbers smaller than the limit
my @abundants = (); # given 12 is the lower abundant number
for(my $k = 1; $k <= NON_ABUNDANT_UPPER_LIMIT; $k++)
{
    my $sum_of_proper_divisors = sum_of_array(@{get_divisors($k)}) - $k;
    push(@abundants, $k) if $sum_of_proper_divisors > $k;
}

## find all numbers that can be written as sum of 2 abundants
my %sum_of_abundants = ();
for(my $k = 0; $k < scalar @abundants; $k++)
{
    for(my $l = $k; $l < scalar @abundants; $l++)
    {
        $sum_of_abundants{($abundants[$k]+$abundants[$l])} = 1;
    }
}

## find all numbers that cannot be written as a sum of 2 abundants based on list
## of ones that can be
for(my $k = 1; $k <= NON_ABUNDANT_UPPER_LIMIT; $k++)
{
    $solution += $k if (!$sum_of_abundants{$k});
}

say "Solution = $solution" if $solution; # 4179871

