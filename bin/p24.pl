#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_permutations);

=pod
A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
=cut

use constant NTH_PERM => 4;
# use constant NTH_PERM => 1_000_000;
use constant CHARS => [ qw(0 1 2) ];
# use constant CHARS => [ qw(0 1 2 3 4 5 6 7 8 9) ];

my $solution = 0;

my $permutations = get_permutations(@{CHARS()});
@$permutations = sort(@$permutations);

say Dumper $permutations;

$solution = $permutations->[NTH_PERM() - 1];

say "Solution = $solution" if $solution; # 

