#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(product_of_array);

=pod
The four adjacent digits in the 1000-digit number that have the greatest product are 9 x 9 x 8 x 9 = 5832.

SEE bin/p8.txt

Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?
=cut

my $BUFFER_SIZE = $ARGV[0] || 13;
my $solution = "unsolved";

## read in the seq
my @digits;
my $digits = "";
my $file = "$Bin/p8.txt";
open(my $fh, $file);
while(my $line = <$fh>)
{
    $digits .= $line;
}
close $fh;

$digits =~ s{[^\d]}{}g;
@digits = split('', $digits);

## make a pass through keeping track of largest product of 13
my $largest_product = 0;
my @buffer;
for(my $k = 0; $k < scalar @digits; $k++)
{
    if(scalar @buffer < $BUFFER_SIZE)
    {
        push(@buffer, $digits[$k]);
        if(scalar @buffer == $BUFFER_SIZE)
        {
            $largest_product = product_of_array(@buffer);
        }
    }
    else
    {
        shift @buffer;
        push(@buffer, $digits[$k]);
        my $p = product_of_array(@buffer);
        $largest_product = $p if $p > $largest_product;
    }
}

$solution = $largest_product;

say "Solution = $solution"; # 23514624000

