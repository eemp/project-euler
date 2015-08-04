#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_sorted_digits);

=pod
Permutated multiples

It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
=cut

my $solution;
my $numPermMultsRequired = 6;

for(my $k = 100; $k < 10_000_000; $k*=10)
{
    my $start = $k;
    my $end = $k*2;
    for(my $x = $start; $x < $end; $x++)
    {
        my $sortedperm = get_sorted_digits($x);
        my $is_permutated_multiple = 1;
        for(my $m = 2; $m <= $numPermMultsRequired; $m++)
        {
            my $mx = $m*$x;
            my $perm = get_sorted_digits($mx);
            if($perm ne $sortedperm)
            {
                $is_permutated_multiple = 0;
                last;
            }
        }
    
        if($is_permutated_multiple)
        {
            $solution = $x;
            last;
        }
    }

    last if $solution;
}

say "Solution = $solution" if $solution; # 142857 

