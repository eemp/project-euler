#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(sum);
use LargeNumber;

=pod
A googol (10^100) is a massive number: one followed by one-hundred zeros; 100^100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a^b, where a, b < 100, what is the maximum digital sum?
=cut

my $solution = 0;
my $maxDigitalSum = 0;
for(my $a = 2; $a < 100; $a++) {
    if($a % 10 == 0) {
        say "a = $a";
        next;
    }
    for(my $b = 2; $b < 100; $b++) {
        my $aRep = LargeNumber->new($a);
        my $res = $aRep->pow($b);
        my $digits = $res->digits;
        my $sum = sum(@$digits);
        if($sum > $maxDigitalSum) {
            $maxDigitalSum = $sum;
        }
    }
}

$solution = $maxDigitalSum;

say "Solution = $solution" if $solution; # 1587000

