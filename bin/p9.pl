#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

=pod
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a^2 + b^2 = c^2
For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
=cut

my $solution;

## create a hash where squares of numbers from 1..1000 are the keys
my %h = ();
my $TARGET_SUM = $ARGV[0] || 1000;
for(my $k = 1; $k < $TARGET_SUM; $k++)
{
    my $k_sq = $k**2;
    $h{$k_sq} = $k;
}

## go through the keys in the hash and check if sum is in the hash
my @ab = ();
my @sorted_squares = sort { $a <=> $b } keys %h;

for(my $k = 0; $k < scalar @sorted_squares; $k++)
{
    for(my $l = 0; $l < scalar @sorted_squares; $l++)
    {
        next if $k == $l;
        my ($a2, $b2, $c2) = ($sorted_squares[$k], $sorted_squares[$l], undef);
        $c2 = $a2 + $b2;

        if($c2)
        {
            my ($a, $b, $c) = ($h{$a2}, $h{$b2}, $h{$c2});
            if($c && $a + $b + $c == $TARGET_SUM)
            {
                $solution = $a*$b*$c;
                last;
            }
        }
    }

    last if $solution;
}

say "Solution = $solution"; # 31875000

