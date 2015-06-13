#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);

# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

## 3 sequences
#  A: 3, 6, 9, ... , 999
#  B: 5, 10, 15, ... , 995
#  C: 15, 30, ... , 990
#  ANSWER = SUM(A) + SUM(B) - SUM(C)

use lib "$Bin/../lib";
use Sequences qw(sum_of_sequence);

# say sum_of_sequence(start => 4, end => 13, interval => 3);
my $sumA = sum_of_sequence(start => 3, end => 999, interval => 3);
my $sumB = sum_of_sequence(start => 5, end => 995, interval => 5);
my $sumC = sum_of_sequence(start => 15, end => 990, interval => 15);

say "Solution = " . ($sumA + $sumB - $sumC);


