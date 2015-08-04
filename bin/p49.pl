#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(get_primes);
use Utils qw(get_sorted_digits);

=pod
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this sequence?
=cut

my $solution;

my %grouped_perms = ();
my $primes = get_primes(10000); # get the 4 dig primes

foreach my $prime (@$primes)
{
    next if length($prime) != 4;
    my $key = get_sorted_digits($prime);
    $grouped_perms{$key} = [] if !$grouped_perms{$key};
    push(@{$grouped_perms{$key}}, $prime);
}

foreach my $k (keys %grouped_perms)
{
    my $group = $grouped_perms{$k};
    next unless (scalar @$group >= 3);
    for(my $fp = 0; $fp < scalar @$group - 1; $fp++) # first prime in sequence
    {
        my %steps = ();
        my $fprime = $group->[$fp];
        for(my $sp = $fp+1; $sp < scalar @$group; $sp++) # second & third
        {
            my $sprime = $group->[$sp];
            my $diff = $sprime - $fprime;
            $steps{$diff} = $sprime;
            if($diff % 2 == 0 && $steps{$diff/2}) # the difference between third prime and first prime in sequence is 2 times
            { # the difference between second and first
                # say Dumper [ $fprime, $steps{$diff/2}, $sprime ];
                my $first = $fprime;
                my $second = $steps{$diff/2};
                my $third = $sprime;
                $solution = "$first$second$third" if $fprime != 1487;
            }
        }
    }
}

say "Solution = $solution" if $solution; # 296962999629 

