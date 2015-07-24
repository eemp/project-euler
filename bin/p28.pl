#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_clockwise_spiral_matrix sum_of_array); 
use Matrix;

=pod
Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
=cut

my $SIZE = $ARGV[0] || 1001;
my $solution;

my $matrix = get_clockwise_spiral_matrix($SIZE);
my $d1 = $matrix->get_left_diagonal();
my $d2 = $matrix->get_right_diagonal();
$solution = sum_of_array(@$d1) + sum_of_array(@$d2) - 1;

say "Solution = $solution" if $solution; # 669171001

