#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_primes);

=pod
The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?
=cut

my $solution;
my $MAX = $ARGV[0] || 1_000_000;

my $primes_list = get_primes(max => $MAX);
my %primes = map { $_ => 1 } @$primes_list;
my @rotating_primes = ();

foreach my $p (@$primes_list)
{
    my @rotations = get_rotations($p);
    my $is_rotating_prime = 1;
    foreach my $r (@rotations)
    {
        $is_rotating_prime = 0 if(!$primes{$r});
    }
    push(@rotating_primes, $p) if $is_rotating_prime;
}

$solution = scalar @rotating_primes;

say "Solution = $solution" if $solution; # 55 

sub get_rotations
{
    my $n = shift;
    my @rotations = ();
    my $len = length($n);
    push(@rotations, $n);
    
    for(my $k = 1; $k < $len; $k++)
    {
        $n = rotate($n);
        push(@rotations, $n);
    }

    return @rotations;
}

sub rotate
{
    my $n = shift;
    my @digits = split('', $n);
    my $first_digit = shift(@digits);
    push(@digits, $first_digit);
    return join('', @digits);
}

