#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(get_primes get_prime_factors_hashref);

=pod
The first two consecutive numbers to have two distinct prime factors are:

14 = 2 x 7
15 = 3 x 5

The first three consecutive numbers to have three distinct prime factors are:

644 = 2^2 x 7 x 23
645 = 3 x 5 x 43
646 = 2 x 17 x 19.

Find the first four consecutive integers to have four distinct prime factors. What is the first of these numbers?
=cut

my $CONSECUTIVE_MATCHES = $ARGV[0] || 4;
my $PRIMES_CACHE_CAP = 1_000_000;
my $SOLUTION_CAP = 1_000_000;

my $solution;
my $k = 1;

get_primes($PRIMES_CACHE_CAP); # get a large list of primes efficiently and have them get cached
# say "cached all primes < $PRIMES_CACHE_CAP...";

while(!$solution && $k < $SOLUTION_CAP)
{
    my (@consecutive_numbers) = ($k..($k+$CONSECUTIVE_MATCHES-1));
    
    my $found_solution = 1;
    foreach my $c (@consecutive_numbers)
    {
        my $prime_factors = get_prime_factors_hashref($c);
        if(scalar(keys %$prime_factors) != $CONSECUTIVE_MATCHES)
        {
            $found_solution = 0;
            $k = $c;
            last;
        }
    }

    if($found_solution)
    {
        $solution = $k;
        last;
    }

    $k++;
}

say "Solution = $solution" if $solution; #  

