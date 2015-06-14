#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_prime_factors);

# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

my $NUMBER = $ARGV[0] || 600_851_475_143;
my $prime_factors = get_prime_factors($NUMBER);
say "Solution = " . $prime_factors->[$#$prime_factors];

