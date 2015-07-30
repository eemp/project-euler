#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(sum_of_array);

=pod
If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p <= 1000, is the number of solutions maximised?
=cut

my $solution;
my $PERIMETER_LIMIT = 1000;
my $SIDE_LEN_LIMIT = 1000;
my $count = 0;

for(my $a = 1; $a <= $SIDE_LEN_LIMIT; $a++)
{
    my $a2 = $a**2;
    for(my $b = $a; $b <= $SIDE_LEN_LIMIT; $b++)
    {
        my $b2 = $b**2;
        my $c2 = $a2 + $b2;
        my $c = int(sqrt($c2));
        my $p = sum_of_array($a, $b, $c);
        if($c**2 == $c2 && $p <= $PERIMETER_LIMIT)
        {
            $count++;
        }
    }
}

$solution = $count;

say "Solution = $solution" if $solution; # 325 

