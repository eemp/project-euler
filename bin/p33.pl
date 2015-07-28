#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Utils qw(gcd);
use Fraction;

=pod
The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
=cut

my $solution;
my $solution_fraction = Fraction->new(1, 1, auto_reduce => 1);

for(my $denominator = 11; $denominator < 100; $denominator++)
{
    next if $denominator % 10 == 0; # avoid trivial

    for(my $numerator = 10; $numerator < $denominator; $numerator++)
    {
        next if ($numerator % 10 == 0); # avoid trivial
        
        my $orig_frac = Fraction->new($numerator, $denominator);
        my $new_frac = Fraction->new(eliminate_common_digit($numerator, $denominator));

        if($orig_frac && $orig_frac->equals($new_frac))
        {
            # say "$numerator / $denominator";
            $solution_fraction->multiply($new_frac);
        }
    }
}

$solution = $solution_fraction->denominator;
say "Solution = $solution" if $solution; # 100

sub eliminate_common_digit
{
    my ($n1, $n2) = @_;
    my %seen = ();
    my $common_digit;
    
    foreach my $digit (split('', $n1), split('', $n2))
    {
        $seen{$digit}++;
    }

    if(scalar(keys %seen) == 3)
    {
        my %reverse_seen = reverse %seen;
        $common_digit = $reverse_seen{2};
    }

    if($common_digit)
    {
        my ($d1) = grep { $_ != $common_digit } split('', $n1);
        my ($d2) = grep { $_ != $common_digit } split('', $n2);
        return ($d1, $d2) if $d1 && $d2;
    }

    return (undef, undef);
}

