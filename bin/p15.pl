#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

=pod
Starting in the top left corner of a 2x2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20x20 grid?
=cut

my $solution;

my @paths = (undef, 2, 6);
for(my $k = 3; $k <= 20; $k++)
{
    push(@paths, $paths[$#paths]*2 + ($k-1)*2);
}

$solution = $paths[20];

say "Solution = $solution" if $solution; # 837799

