#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use LargeNumber;

=pod
The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?
=cut

my $solution;

my $n = 1;
my $base = 1;
my $base_n = LargeNumber->new(1);
my $count = 0;

# brute force approach
# we know $base < 10
# and figured out from observation of
# executions of this script that at some point # of digits of numOfDigits(9^n) < n
# that's the stopping point

while(!($base == 9 && scalar @{$base_n->digits} < $n)) { # arbitrary cap of 22 determined during dev (nothing comes out after)
    # say "base = $base ^ n = $n";
    if(scalar @{$base_n->digits} == $n) {
        $count++;
        # say "$base ^ $n, count = $count";
    }

    if(scalar @{$base_n->digits} <= $n) {
        $base++;
    }
    else {
        $n++;
        $base = 2;
    }

    $base_n = LargeNumber->new($base);
    $base_n = $base_n->pow($n);
}

$solution = $count; # 49

say "Solution = $solution" if $solution;

