#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(get_words_for_number);

=pod
If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?


NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
=cut

my $solution;

# say get_words_for_number(1_032_542);
# say get_words_for_number(1_342);
# say get_words_for_number(342);
# say get_words_for_number(115);
# say get_words_for_number(5);

my $total_letters = 0;

for(my $k = 1; $k <= 1000; $k++)
{
    my $words = get_words_for_number($k);
    # say "$k => $words";
    $words =~ s/[^a-z]//g;
    $total_letters += length($words);
}

$solution = $total_letters;

say "Solution = $solution" if $solution; # 21124

