#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(factorial get_digits sum_of_array);

=pod
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
=cut

my $solution;
my $max;
my $sum;

my $largest_possible_sum = 0; # sum of 9 factorials
my $nines_num = ''; # number you get when you keep tagging on a nines digit
# when $largest_possible_sum < $nines_num, found a limit
for(my $k = 0; $k < 20; $k++)
{
    $nines_num .= '9';
    $nines_num = int($nines_num);
    $largest_possible_sum += factorial(9);

    if($largest_possible_sum < $nines_num)
    {
        $max = $largest_possible_sum;
    }
}

my @factorials_map = ();
for(my $k = 0; $k < 10; $k++)
{
     push(@factorials_map, factorial($k));
}

for(my $k = 3; $k <= $max; $k++)
{
    my $digits = get_digits($k);
    my @factorials_of_digits = map { $factorials_map[$_] } @$digits;
    my $sum_of_factorials = sum_of_array(@factorials_of_digits);
    if($sum_of_factorials == $k)
    {
        $sum += $k;
        # say "found $k...";
    }
}

$solution = $sum;

say "Solution = $solution" if $solution; # 40730

