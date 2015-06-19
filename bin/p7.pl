#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

=pod
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10 001st prime number?
=cut

my $SIEVE_SIZE = $ARGV[0] || 1_000_000;

my $solution;

## Erathosthenes Sieve
my @primes = ();
my @sieve = ();
for(my $k = 0; $k < $SIEVE_SIZE; $k++) { push(@sieve, $k); }

for(my $k = 2; $k < scalar @sieve; $k++)
{
    if($sieve[$k] != 0)
    {
        push(@primes, $k);
        for(my $l = $k; $l < scalar @sieve; $l+=$k)
        {
            $sieve[$l] = 0;
        }
    }
}

$solution = $primes[10_000]; # prime # 10,001... 0 index

say "Solution = $solution" if $solution; # 104759

