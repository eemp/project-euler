#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(is_pandigital get_digits sum_of_array);

=pod
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
=cut

my $solution;

my %pandigital_products = ();

my ($k, $l); # multiplier, multiplicand

for($k = 2; $k < 10000; $k++)
{
    for(my $l = 2; $l < 1000; $l++)
    {
        my $product = $k * $l;
        my $panDigitalNumber = join('', $k, $l, $product);
        my $digits = get_digits($panDigitalNumber);

        last if (scalar @$digits > 9);
        next if(scalar @$digits != 9);

        if(is_pandigital(digits => $digits, pandigits => [ qw( 1 2 3 4 5 6 7 8 9 ) ]))
        {
            say "$k * $l = $product";
            $pandigital_products{$product} = 1;
        }
    }
}

$solution = sum_of_array(keys %pandigital_products);

say "Solution = $solution" if $solution; # 45228

