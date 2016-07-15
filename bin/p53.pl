#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use ProductChain;
use Utils qw(combinatorics);

=pod
There are exactly ten ways of selecting three from five, 12345:

123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, 5C3 = 10.

In general,

nCr = n!/(r!(n-r)!)

where r <= n, n! = nx(n-1)x...x3x2x1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are greater than one-million?
=cut

my $solution;

my $count = 0;
for(my $n = 1; $n <= 100; $n++) {
    for(my $r = 1; $r <= $n; $r++) {
        my $val = combinatorics($n, $r);
        $count++ if($val > 1_000_000);
    }
}

$solution = $count;

say "Solution = $solution" if $solution;


