#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_primes);

=pod
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10 001st prime number?
=cut

my $SIEVE_SIZE = $ARGV[0] || 1_000_000;

my $solution;
my $primes = get_primes(max => $SIEVE_SIZE);

$solution = $primes->[10_000]; # prime # 10,001... 0 index

say "Solution = $solution" if $solution; # 104743

