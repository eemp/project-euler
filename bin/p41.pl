#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(is_prime);
use Utils qw(get_permutations is_pandigital);

=pod
Pandigital prime

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
=cut

my $solution;

for(my $k = 9; $k >= 4; $k--)
{
    my @digits = (1..$k);
    @digits = reverse(@digits);
    
    my $possible_permutations = get_permutations(\@digits);
    
    foreach my $c (@$possible_permutations)
    {
        if(is_prime(int($c)))
        {
            $solution = $c;
            last;
        }
    }

    last if $solution;
}

say "Solution = $solution" if $solution; # 7652413 

