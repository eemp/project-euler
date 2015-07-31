#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_permutations);

=pod
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.
=cut

my $solution;

my @TESTS = (
    sub { my $t = shift; my $subt = int(substr($t,1,3)); return ($subt % 2 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,2,3)); return ($subt % 3 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,3,3)); return ($subt % 5 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,4,3)); return ($subt % 7 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,5,3)); return ($subt % 11 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,6,3)); return ($subt % 13 == 0); },
    sub { my $t = shift; my $subt = int(substr($t,7,3)); return ($subt % 17 == 0); },
);

my $permutations = get_permutations("0123456789");
my $sum = 0;
foreach my $p (@$permutations)
{
    # skip ones with leading 0
    next if substr($p, 0, 1) == 0;

    my $passed_tests = 0;
    foreach my $t (@TESTS)
    {
        $passed_tests++ if($t->($p));
    }
    $sum += int($p) if (scalar @TESTS == $passed_tests);
}

$solution = $sum;

say "Solution = $solution" if $solution; # 16695334890 

