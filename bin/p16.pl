#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(sum_of_array);

=pod
2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?
=cut

my $solution;

my $k;
my @num = (2); # 2^1
my $max_exp = $ARGV[0] || 1000;

# 2^2 ... 2^m (where m = 1000 for this problem)
for($k = 2; $k <= $max_exp; $k++)
{
    my $carry = 0;
    my @next_num = ();
    for(my $d = $#num; $d >= 0; $d--)
    {
        my $product = $num[$d]*2 + $carry;
        unshift(@next_num, $product % 10);
        $carry = int($product/10);
    }
    
    while($carry)
    {
        my $next_digit = $carry % 10;
        unshift(@next_num, $next_digit);
        $carry = int($carry/10);
    }

    @num = @next_num;
}

$solution = sum_of_array(@num);

say "Solution = $solution" if $solution; # 1366

