#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Utils qw(get_counter_clockwise_spiral_matrix);
use Primes qw(get_primes is_prime);

=pod
Spiral primes

Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

37 36 35 34 33 32 31
38 17 16 15 14 13 30
39 18  5  4  3 12 29
40 19  6  1  2 11 28
41 20  7  8  9 10 27
42 21 22 23 24 25 26
43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ? 62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
=cut

my $solution;
my $THRESHOLD = 0.1;

=pod
my %is_primes_h = map { $_ => 1 } @{get_primes(1_000_000)};

for(my $size = 7; $size < 1_000; $size+=2)
{
    my $m = get_counter_clockwise_spiral_matrix($size);
    my $d1 = $m->get_left_diagonal();
    my $d2 = $m->get_right_diagonal();
    my $primes_count = 0;
    my $total_num = scalar @$d1 + scalar @$d2 - 1;
    foreach my $n (@$d1, @$d2)
    {
        $primes_count++ if($is_primes_h{$n});
    }
    my $percentage = $primes_count/$total_num;
    say $percentage;
    if($percentage < $THRESHOLD)
    {
        $solution = $size;
        last;
    }
}

## well that's too inefficient...
=cut

## instead of calculating the matrices, let's just calculate the diagonals
my $diagonal_elements = 1;  # start off with 1 (the center element)
my $prime_elements = 0; # and 1 is not prime
my $last_marker = 1; # track the last corner of prev layer

my $layer = 0;
my $total = 1;

while(!$solution)
{
    $layer += 2;
    my @curr_layer_elements = (
        $last_marker + $layer,
        $last_marker + 2*$layer,
        $last_marker + 3*$layer,
        $last_marker + 4*$layer
    ); # only diag elements

    $total += scalar @curr_layer_elements;

    foreach my $n (@curr_layer_elements)
    {
        $prime_elements++ if(is_prime($n));
    }

    my $percentage = $prime_elements / $total;
    $solution = $layer + 1 if ($percentage < $THRESHOLD);
    
    # say $layer + 1 . " => primes: " . $prime_elements . ", percentage: " . $prime_elements / $total;
    
    $last_marker = $curr_layer_elements[$#curr_layer_elements];
}

say "Solution = $solution" if $solution; # 26241 

