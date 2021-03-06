#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Sequences qw(get_triangle_numbers get_pentagonal_numbers get_hexagonal_numbers);

=pod
Triangle, pentagonal, and hexagonal numbers are generated by the following formulae:

Triangle    Tn=n(n+1)/2     1, 3, 6, 10, 15, ...
Pentagonal  Pn=n(3n-1)/2    1, 5, 12, 22, 35, ...
Hexagonal   Hn=n(2n-1)2n    1, 6, 15, 28, 45, ...
It can be verified that T285 = P165 = H143 = 40755.

Find the next triangle number that is also pentagonal and hexagonal.
=cut

use constant MAXN => 1_000_000;

my $solution;

my $n6 = 1;
my ($n5, $next_n5) = (1, 0);
my ($n3, $next_n3) = (1, 0);

for(my $n6 = 1; $n6 < MAXN; $n6++)
{
    my $next_n6 = get_hexagonal_numbers(n => $n6);
    
    while($next_n6 > $next_n5)
    {
        $next_n5 = get_pentagonal_numbers(n => $n5++);
    }

    while($next_n6 > $next_n3)
    {
        $next_n3 = get_triangle_numbers(n => $n3++);
    }

    if($next_n6 == $next_n5 && $next_n6 == $next_n3)
    {
        $solution = $next_n6 if $next_n6 > 40755;
    }

    last if $solution;
}

say "Solution = $solution" if $solution; # 1533776805 

