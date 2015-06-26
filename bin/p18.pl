#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(max);

=pod
By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:

SEE bin/p18.txt

NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)
=cut

my $solution;

## read in the triangle
my $file = $ARGV[0] || "$Bin/p18.txt";
my @triangle = ();
open(my $fh, $file);
while(my $line = <$fh>)
{
    chomp($line);
    push(@triangle, [ split(m{[^\d]}, $line) ]) if $line;
}
close $fh;

# bottom up
for(my $k = $#triangle - 1; $k >= 0; $k--)
{
    my $curr_row = $triangle[$k];
    my $next_row = $triangle[$k+1];
    for(my $l = 0; $l < scalar @$curr_row; $l++)
    {
        $curr_row->[$l] += max($next_row->[$l], $next_row->[$l+1]);
    }
}

$solution = $triangle[0][0];

say "Solution = $solution" if $solution; # 1074

