#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_primes);
use Utils qw(sum_of_array);

=pod
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below two million.
=cut

my $SIEVE_SIZE = $ARGV[0] || 2_000_000;

my $solution;
my $primes = get_primes(max => $SIEVE_SIZE);

$solution = sum_of_array(@$primes);

say "Solution = $solution" if $solution; # 142913828922

