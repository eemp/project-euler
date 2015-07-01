#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Fibonacci qw(get_first_in_sequence);
use Utils qw(sum_array_refs_of_numbers);

=pod
The Fibonacci sequence is defined by the recurrence relation:

Fn = Fn-1 + Fn-2, where F1 = 1 and F2 = 1.
Hence the first 12 terms will be:

F1 = 1
F2 = 1
F3 = 2
F4 = 3
F5 = 5
F6 = 8
F7 = 13
F8 = 21
F9 = 34
F10 = 55
F11 = 89
F12 = 144
The 12th term, F12, is the first term to contain three digits.

What is the index of the first term in the Fibonacci sequence to contain 1000 digits?
=cut

# use constant DIGITS_IN_FIB_TERM => 3;
use constant DIGITS_IN_FIB_TERM => 1000;

my ($solution, $element) = get_first_in_sequence(
    first => 1,
    second => 1,
    end => sub {
        my $element = shift;
        my $len = scalar @$element;
        return $len == DIGITS_IN_FIB_TERM() ? 1 : 0;
    }
);


say "Solution = $solution" if $solution; # 4782

