#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

use Sequences qw(sum_of_sequence);

=pod
The sum of the squares of the first ten natural numbers is,

1^2 + 2^2 + ... + 10^2 = 385
The square of the sum of the first ten natural numbers is,

(1 + 2 + ... + 10)^2 = 552 = 3025
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
=cut

## solution = A - B, where
my $solution;

## A = square of sum
my $A = sum_of_sequence(start => 1, end => 100);
$A = $A**2;

## B = sum of squares
my $B = 0;
for(my $k = 1; $k <= 100; $k++)
{
    my $square = $k**2;
    $B += $square;
}

$solution = $A - $B;

say "Solution = $solution"; # 25164150

