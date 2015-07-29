#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Palindromes qw(is_palindrome);
use Utils qw(get_baseN);

=pod
The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
=cut

my $solution;

my $MAX = $ARGV[0] || 1_000_000;
my $sum = 0;

for(my $k = 1; $k < $MAX; $k++)
{
    # say "$k" if is_double_palindrome($k);
    $sum += $k if is_double_palindrome($k);
}

$solution = $sum;

say "Solution = $solution" if $solution; # 872187 

sub is_double_palindrome
{
    my $n = shift;
    my $n_base2 = get_baseN($n, 2);
    if(is_palindrome($n) && is_palindrome($n_base2))
    {
        return 1;
    }
    return 0;
}

