#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

=pod
In England the currency is made up of pound, ?, and pence, p, and there are eight coins in general circulation:

1p, 2p, 5p, 10p, 20p, 50p, ?1 (100p) and ?2 (200p).
It is possible to make ?2 in the following way:

1x?1 + 1x50p + 2x20p + 1x5p + 1x2p + 3x1p
How many different ways can ?2 be made using any number of coins?
=cut

my $solution;

my $amount = 200;
# my @coinValues = (1, 2, 5, 10, 20, 50, 100, 200);
my @coinValues = (200, 100, 50, 20, 10, 5, 2, 1);

=pod
# $goal = 5;
# possible combinations: 
# * 1-5
# * 2-2, 1-1
# * 2-1, 1-3
# * 5-1

$amount = 5;
@coinValues = (1, 2, 5);
=cut

my $possibleCombinations = getPossibleCombinationsToComposeAmount($amount, @coinValues);
=pod
foreach my $pc (@$possibleCombinations) {
    my @pcStr = ();
    foreach my $coinValue (@coinValues) {
        my $q = $pc->{$coinValue};
        if($q) {
            push(@pcStr, "($coinValue) x $q");
        }
    }

    say join(", ", @pcStr);
}
=cut

$solution = scalar @$possibleCombinations; # 73682

say "Solution = $solution" if $solution;

sub getPossibleNumberOfCoins
{
    my ($coinValue, $cap) = @_;
    my @validQuantities = ();
    my $quantity = 0;
    while($quantity*$coinValue <= $cap) {
        push(@validQuantities, $quantity++);
    }
    return \@validQuantities;
}

sub getPossibleCombinationsToComposeAmount
{
    my ($amount, @availableCoins) = @_;
    
    # not going to handle @$availableCoins = 0
    if(scalar @availableCoins == 1) {
        my $coinValue = $availableCoins[0];
        my $quantity = int($amount/$coinValue);
        if($quantity * $coinValue == $amount) {
            return [{$coinValue => $quantity}];
        }
        else {
            return undef;
        }
    }
    
    my $coinValue = $availableCoins[0];
    my $validQuantities = getPossibleNumberOfCoins($coinValue, $amount);
    my @combinations = ();
    
    foreach my $quantity (@$validQuantities) {
        my $value = $quantity * $coinValue;
        my $remainder = $amount - $value;
        my @remainingCoins = @availableCoins[1..($#availableCoins)];
        my $possibleSubCombinations =
            getPossibleCombinationsToComposeAmount($remainder, @remainingCoins);
        
        foreach my $psc (@$possibleSubCombinations) {
            if($psc) {
                $psc->{$coinValue} = $quantity;
                push(@combinations, $psc);
            }
        }
    }
    
    return \@combinations;
}

