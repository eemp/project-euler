#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_prime_factors_hashref);

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

# let's loop k from 1->20
# consider the prime factors of each k
# keep a profile of the prime factors for each
# AND the max number of prime factors required
# for example, two 2's make 4, but four 2's make 16
# so at least four 4's must make solution
my $solution;
my $required_factors = {};
my $k = 2;
for($k = 2; $k <= 20; $k++)
{
    my $k_factors = get_prime_factors_hashref($k);
    ## update required_factors
    foreach my $f (keys %$k_factors)
    {
        $required_factors->{$f} = $k_factors->{$f}
            if (!$required_factors->{$f} || $required_factors->{$f} < $k_factors->{$f});
    }
}

$solution = 1;
foreach my $f (keys %$required_factors)
{
    $solution *= ($f**$required_factors->{$f});
}

say "Solution = $solution";

