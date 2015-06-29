#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_divisors sum_of_array);

=pod
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
=cut

my $solution;

my %divisor_sums_map = ();
my %amicables = ();
my $amicables_sum = 0;
for(my $k = 2; $k < 10000; $k++)
{
    my ($divisors, $total_divisors) = get_divisors($k);
    my $divisors_sum = sum_of_array(@$divisors) - $k;
    $divisor_sums_map{$k} = $divisors_sum;
    # say "$k => $divisors_sum";
}

foreach my $key (keys %divisor_sums_map)
{
    my $sum = $divisor_sums_map{$key};
    if($key != $sum && $divisor_sums_map{$sum} && $divisor_sums_map{$sum} == $key)
    {
        $amicables_sum += $key;
        $amicables_sum += $sum;
        $amicables{$key} = $sum;
        $amicables{$sum} = $key;
        # say "$key <=> $sum";
    }
}

$solution = $amicables_sum;

say "Solution = $solution" if $solution; # 63252

