#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(max);

=pod
Self powers

The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
=cut

$Data::Dumper::Indent = 0;

my $solution;

my $REQUIRED_NUM_OF_DIGITS = $ARGV[1] || 10;
my $UPTO = $ARGV[0] || 1000;

my @last_digits = (0) x $REQUIRED_NUM_OF_DIGITS;
my $actual_num = 0;

for(my $k = 1; $k <= $UPTO; $k++)
{
    my $num_leading_zeros = $REQUIRED_NUM_OF_DIGITS - length($k);
    my @leading_zeros = $num_leading_zeros > 0 ? (0) x $num_leading_zeros : ();
    my @term_digits = ( @leading_zeros,  split('', $k) );
    my $actual_term = $k;
    my $carry;

    ## figure out the last 10 digits of the term ($k^$k)
    for(my $power = 2; $power <= $k; $power++)
    {
        $carry = 0;
        $actual_term *= $k;
        for(my $d = $#term_digits; $d >= 0; $d--)
        {
            my $digit = $term_digits[$d];
            my $r = ($k * $digit) + $carry;
            $term_digits[$d] = $r % 10;
            $carry = int($r/10);
        }
    }
   
    ## add them to the sum
    $actual_num += $actual_term;
    $carry = 0;
    for(my $d = $#last_digits; $d >= 0; $d--)
    {
        my $sum = $term_digits[$d] + $last_digits[$d] + $carry;
        $last_digits[$d] = $sum % 10;
        $carry = int($sum/10);
    }

    # say $actual_num;
    # say Dumper \@last_digits;
}

$solution = join('', @last_digits);
say "Solution = $solution" if $solution; # 9110846700 

