#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_word_value);
use Sequences qw(get_triangle_numbers);

=pod
The nth term of the sequence of triangle numbers is given by, tn =  1/2 n(n+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
=cut

use constant TRI_GET_STEP_SIZE => 1000;

my $solution;

my $file = "$Bin/p42.txt";
open(my $fh, $file);
my $words_string = <$fh>;
close $fh;

my @words = split(',', $words_string);
@words = map { $_ =~ s/"//g; $_ } @words;

my $triangle_step = TRI_GET_STEP_SIZE();
my $triangle_numbers = get_triangle_numbers(max_n => $triangle_step);
my %triangle_numbers_map = map { $_ => 1 } @$triangle_numbers;

my $triangle_words_count = 0;

foreach my $w (@words)
{
    my $wv = get_word_value($w);
    while($wv > $triangle_numbers->[$#$triangle_numbers])
    {
        $triangle_step += TRI_GET_STEP_SIZE();
        $triangle_numbers = get_triangle_numbers($triangle_step);
        %triangle_numbers_map = map { $_ => 1 } @$triangle_numbers;
    }
    $triangle_words_count++ if ($triangle_numbers_map{$wv});
}

$solution = $triangle_words_count;

say "Solution = $solution" if $solution; # 162 

