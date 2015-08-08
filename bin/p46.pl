#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(get_primes);

=pod
It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2x1^2
15 = 7 + 2x2^2
21 = 3 + 2x3^2
25 = 7 + 2x3^2
27 = 19 + 2x2^2
33 = 31 + 2x1^2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
=cut

my $solution;

my $CAP = $ARGV[0] || 1_000_000;
my $primes = get_primes($CAP);
my %is_primes_h = map { $_ => 1 } @$primes;
my $squares = [ map { $_**2 } (1..($CAP)) ];

for(my $k = 9; $k < $CAP; $k += 2)
{
    next if $is_primes_h{$k};
    my $fits_goldbach = 0;

    for(my $p = 0; $p < scalar @$primes; $p++)
    {
        my $prime = $primes->[$p];
        for(my $s = 0; $s < scalar @$squares; $s++)
        {
            my $square = $squares->[$s];
            if($k == $prime + 2*$square)
            {
                $fits_goldbach = 1;
            }

            last if ($prime + 2*$square) > $k;
            last if $fits_goldbach;
        }

        last if $prime > $k;
        last if $fits_goldbach;
    }

    if(!$fits_goldbach)
    {
        $solution = $k;
    }

    last if $solution;
}

say "Solution = $solution" if $solution; # 5777 

