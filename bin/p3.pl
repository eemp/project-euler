#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(getPrimeFactors);

# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

my $solution;
my $n = $ARGV[0] || 600_851_475_143;
my $factors = getPrimeFactors($n);
my @sortedFactors = sort { $b <=> $a } keys %$factors;
my $largestFactor = $sortedFactors[0];
$solution = $largestFactor;
say "Solution = $solution" if $solution; # 6857

