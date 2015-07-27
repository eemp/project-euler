#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Matrix;

=pod
Starting in the top left corner of a 2x2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20x20 grid?
=cut

my $solution;

my $LATTICE_SIZE = 20;
# each cell in $mat will represet a vertex in the lattice
# the values in $mat will represent the options available at that vertex
# values are filled in based on options available from the right and top
my $mat_size = $LATTICE_SIZE + 1;
my $mat = Matrix->new($mat_size);

# fill in intial values
$mat->set(1,1 => 0);
for(my $k = 2; $k <= $mat_size; $k++)
{
    $mat->set(1,$k => 1);
    $mat->set($k,1 => 1);
}

# $mat->print();
for(my $k = 2; $k <= $mat_size; $k++)
{
    for(my $l = 2; $l <= $mat_size; $l++)
    {
        my $available_paths = $mat->get($k, $l-1) + $mat->get($k-1, $l);
        $mat->set($k,$l => $available_paths);
    }
}

# $mat->print();
$solution = $mat->get($mat_size, $mat_size); # 137846528820

say "Solution = $solution" if $solution; # 

