#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_digits sum);

=pod
A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

For example,

44 -> 32 -> 13 -> 10 -> 1 -> 1
85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?
=cut

my $solution = 0;
my %cache = (1 => 1, 89 => 89);

my $LIMIT = 10_000_000;

# we know 1 and (1,2,3,4,5,6,7,8,9) fits but smaller than the one provided in the example
for(my $k = 2; $k < $LIMIT; $k++)
{
    my $result = getSquareDigitChainResult($k);
    if($result == 89) {
        $solution++;
    }

    if($k % 1_000_000 == 0) {
        say "K = $k";
    }
}

say "Solution = $solution" if $solution; # 8581146 

# could just memoize this
sub getSquareDigitChainResult
{
    my $n = shift;
    return $cache{$n} if(defined $cache{$n});
    
    # my $digits = get_digits($n);
    # my $squares = [map {$_*$_} @$digits];
    my @digits = split('', $n);
    my $sumOfSquaredDigits = 0;
    $sumOfSquaredDigits += ($_*$_) foreach (@digits);

    # return ($cache{$n} = getSquareDigitChainResult(sum(@$squares)));
    return ($cache{$n} = getSquareDigitChainResult($sumOfSquaredDigits));
}

