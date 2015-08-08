#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_digits sum_of_array);

=pod
Factorial Digit Sum
n! means n x (n - 1) x ... x 3 x 2 x 1

For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
    and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!
=cut

my $solution;

my $n = $ARGV[0] || 100;
my $factorial = [1];

for(my $k = 1; $k <= $n; $k++)
{
    $factorial = get_product($factorial, $k);
}

$solution = sum_of_array(@$factorial);

say "Solution = $solution" if $solution; # 648

sub get_product
{
    my ($largenum, $num) = @_;
    my $product = [];
    my $carry = 0;
    foreach my $digit (reverse @$largenum)
    {
        my $next_digit = ($digit * $num + $carry) % 10;
        $carry = int(($digit * $num + $carry) / 10);
        unshift(@$product, $next_digit);
    }

    @$product = (@{get_digits($carry)}, @$product) if $carry;

    return $product;
}

