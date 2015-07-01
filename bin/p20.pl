#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_prime_factors);
use Utils qw(factorial sum_of_digits);

=pod
n! means n x (n - 1) x ... x 3 x 2 x 1

For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
=cut

my $solution;

for(my $k = 1; $k <= 20; $k++)
{
    my $factorial_k = factorial($k);
    my $sum_of_digits = sum_of_digits($factorial_k);
    say "$k => $factorial_k => $sum_of_digits";
}

say "Solution = $solution" if $solution; # 1074

