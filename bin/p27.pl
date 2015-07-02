#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(is_prime get_primes); 

=pod
Euler discovered the remarkable quadratic formula:

n? + n + 41

It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41? + 41 + 41 is clearly divisible by 41.

The incredible formula  n? - 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, -79 and 1601, is -126479.

Considering quadratics of the form:

n^2 + an + b, where |a| < 1000 and |b| < 1000

where |n| is the modulus/absolute value of n
e.g. |11| = 11 and |-4| = 4
Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
=cut

use constant PRIMES_SIEVE_CAP => 1_000_000;
use constant MAX_A => 1000;
use constant MAX_B => 1000;

my $solution;

my $QFORM = sub {
    my ($n, $a, $b) = @_;
    return ($n*$n + $a*$n + $b);
};
my $primes = get_primes(max => PRIMES_SIEVE_CAP());
my %primes_cache = map { $_ => 1 } @$primes;

# say get_max_consecutive_primes_for_formula(-79, 1601);
# say get_max_consecutive_primes_for_formula(1,41);

my $max_consecutive_primes = 0;
my $max_product;
for(my $a = -1*MAX_A() + 1; $a < MAX_A(); $a++)
{
    for(my $b = -1*MAX_B() + 1; $b < MAX_B(); $b++)
    {
        my $total_consecutive_primes = get_max_consecutive_primes_for_formula($a, $b);
        if($total_consecutive_primes > $max_consecutive_primes)
        {
            $max_consecutive_primes = $total_consecutive_primes;
            $max_product = $a*$b;
        }
    }
}

$solution = $max_product;

say "Solution = $solution" if $solution; # -59231

sub get_max_consecutive_primes_for_formula
{
    my $n = 0;
    my $a = shift;
    my $b = shift;
    my $curr = &$QFORM($n, $a, $b);
    while($primes_cache{$curr} || ($curr > PRIMES_SIEVE_CAP() && is_prime($curr)))
    {
        $curr = &$QFORM(++$n, $a, $b);
    }
    return $n;
}

