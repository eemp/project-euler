#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";

=pod
Champernowne's constant

An irrational decimal fraction is created by concatenating the positive integers:

0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If dn represents the nth digit of the fractional part, find the value of the following expression.

d1 x d10 x d100 x d1000 x d10000 x d100000 x d1000000
=cut

my $solution;

my $champernowne_fractional_digits = get_champ_digits(1_000_000);

$solution = 
    int(substr($champernowne_fractional_digits, 0, 1)) *
    int(substr($champernowne_fractional_digits, 9, 1)) *
    int(substr($champernowne_fractional_digits, 99, 1)) *
    int(substr($champernowne_fractional_digits, 999, 1)) *
    int(substr($champernowne_fractional_digits, 9_999, 1)) *
    int(substr($champernowne_fractional_digits, 99_999, 1)) *
    int(substr($champernowne_fractional_digits, 999_999, 1)) ;

say "Solution = $solution" if $solution; # 210 

# does not necessarily return the digits requested
# may return more (will tag on the nearest number so that digit req is satisfied)
sub get_champ_digits
{
    my $required_digits = shift;
    my $digits = "";
    my $currn = 1;
    while(length($digits) < $required_digits)
    {
        $digits .= $currn;
        $currn++;
    }
    return $digits;
}

