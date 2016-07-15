#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_primes is_prime);
use Utils qw(sum);

=pod
The prime 41, can be written as the sum of six consecutive primes:

41 = 2 + 3 + 5 + 7 + 11 + 13
This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?
=cut

my $solution;

my $primes = get_primes(1_000_000);
my $maxPrime = $primes->[-1];

## figure out max size of sequence to start off with and go down
my $sequenceSize = 0;
my $sequenceSum = 0;
foreach my $prime (@$primes) {
    $sequenceSum += $prime;
    $sequenceSize++;
    if($sequenceSum >= $maxPrime) {
        $solution = $maxPrime if $sequenceSum == $maxPrime;
        last;
    }
}

## loop through sequence sizes going from max sequence size down
while(!$solution) {
    my $startIndex = 0;
    
    do {
        my $finalIndex = $startIndex + $sequenceSize - 1;
        my @sequence = @$primes[$startIndex..$finalIndex];
        
        $sequenceSum = sum(@sequence);
        if(is_prime($sequenceSum)) {
            $solution = $sequenceSum;
            last;
        }

        $startIndex++;
    } while ($sequenceSum <= $maxPrime);

    $sequenceSize--;
}

say "Solution = $solution" if $solution;

