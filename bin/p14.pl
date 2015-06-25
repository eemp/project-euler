#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Sequences qw(get_collatz_sequence_size);

=pod
The following iterative sequence is defined for the set of positive integers:

n -> n/2 (n is even)
n -> 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.
=cut

my $solution;

# given
my $longest_seq_size = 10;
my $number_with_longest_seq = 13;

my $MAX = 1_000_000;

# say Dumper get_collatz_sequence_size(13);
# say Dumper get_collatz_sequence_size(26);

for(my $k = 1; $k < $MAX; $k++)
{
    my $seq_size = get_collatz_sequence_size($k);
    if($seq_size > $longest_seq_size)
    {
        $longest_seq_size = $seq_size;
        $number_with_longest_seq = $k;
    }
}

$solution = $number_with_longest_seq;

say "Solution = $solution" if $solution; # 837799

