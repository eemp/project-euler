#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(getPrimeFactors);

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

my $solution;
my $k = 1;

while(!$solution)
{
    my (@consecutive_numbers) = ($k..($k+$CONSECUTIVE_MATCHES-1));
    my $found_solution = 1;
    
    for(my $l = $#consecutive_numbers; $l >= 0; $l--)
    {
        my $n = $consecutive_numbers[$l];
        my $prime_factors = getPrimeFactors($n);
        if(scalar(keys %$prime_factors) != $CONSECUTIVE_MATCHES)
        {
            $found_solution = 0;
            $k = $n;
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

say "Solution = $solution" if $solution; # 134043 

