#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(is_pandigital);

=pod
Take the number 192 and multiply it by each of 1, 2, and 3:

192 x 1 = 192
192 x 2 = 384
192 x 3 = 576
By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
=cut

my $solution;

my $LIMIT = 10_000; # 100_000_000; # Can cut the limit down just based on the fact that in order for (1,2) and n to
# produce a concatenated product that is pandigital the number of digits involved can help reduce the limit significantly
my $max = 918273645;
my $maxn;

# we know 1 and (1,2,3,4,5,6,7,8,9) fits but smaller than the one provided in the example
for(my $k = 2; $k < $LIMIT; $k++)
{
    my $cp = get_concatenated_product($k);
    if($cp && is_pandigital(numbers => $cp, pandigits => [ qw( 1 2 3 4 5 6 7 8 9 ) ]))
    {
        if($cp > $max)
        {
            $maxn = $k;
            $max = $cp;
        }
    }
}

$solution = $max;

say "Solution = $solution" if $solution; # 932718654 

sub get_concatenated_product
{
    my $n = shift;
    my $concatenated_product = "";
    for(my $k = 1; $k <= 9; $k++)
    {
        my $product = $n * $k;
        $concatenated_product .= $product;

        last if length($concatenated_product) >= 9;
    }
    return $concatenated_product;
}

