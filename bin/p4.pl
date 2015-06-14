#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Palindromes qw(is_palindrome);

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 x 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

my $largest_palindrome = 1;
for(my $k = 999; $k >= 100; $k--)
{
    for(my $l = 999; $l >= 100; $l--)
    {
        my $n = $k*$l;
        $largest_palindrome = $n if($largest_palindrome < $n && is_palindrome($n));
    }

    last if($k * 999 < $largest_palindrome);
}

say "Solution = $largest_palindrome";

