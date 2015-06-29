#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";

=pod
Using bin/p22.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 x 53 = 49714.

What is the total of all the name scores in the file?
=cut

my $solution = 0;

my $score = 1;
my %char_scores = map { uc($_) => $score++ } qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

## get names
my @names = (); # processed clean names
my $file = "$Bin/p22.txt";
open(my $fh, $file);
my $line = <$fh>;
close($fh);
my @parts = split(m{\s*,\s*}, $line);
foreach my $name_part (@parts)
{
    if($name_part =~ m{^"(?<name>[A-Z]+)"$})
    {
        push(@names, $+{name});
    }
    else
    {
        die "ERROR: Unexpected name pattern found - $line";
    }
}
## sort
@names = sort @names;

## total score = sum of scores for each name
my $k = 1;
foreach my $name (@names)
{
    $solution += (get_score($name)*$k);
    $k++;
}

say "Solution = $solution" if $solution; # 871198282

sub get_score
{
    my @chars = split('', shift);
    my $score = 0;
    foreach my $char (@chars)
    {
        $score += $char_scores{$char};
    }
    return $score;
}

