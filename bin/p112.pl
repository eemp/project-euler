#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Utils qw(get_digits);

=pod
Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.

Similarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.

We shall call a positive integer that is neither increasing nor decreasing a "bouncy" number; for example, 155349.

Clearly there cannot be any bouncy numbers below one-hundred, but just over half of the numbers below one-thousand (525) are bouncy. In fact, the least number for which the proportion of bouncy numbers first reaches 50% is 538.

Surprisingly, bouncy numbers become more and more common and by the time we reach 21780 the proportion of bouncy numbers is equal to 90%.

Find the least number for which the proportion of bouncy numbers is exactly 99%.
=cut

my $solution = 0;
# my $TARGET = 0.90;
my $TARGET = 0.99;

my $ratio = 0;
my $k = 100;
my $bouncyCount = 0;

=pod
my @tests = (134468, 66420, 155349, 555);
foreach my $t (@tests) {
    warn "$t : " . isBouncy($t);
}
die 'done';
=cut

while($ratio != $TARGET) {
    $k++; # start of @ 101
    $bouncyCount++ if(isBouncy($k));
    $ratio = $bouncyCount/$k;
}

$solution = $k;

say "Solution = $solution" if $solution; # 1587000

sub isBouncy
{
    my $n = shift;
    my $digits = get_digits($n);
    my %encounteredDirectionFlags = ();

    for(my $k = 0; $k < (scalar @$digits - 1); $k++) {
        my $directionFlag = 0; # same
        if($digits->[$k] > $digits->[$k+1]) {
            $directionFlag = 1;
        }
        elsif($digits->[$k] < $digits->[$k+1]) {
            $directionFlag = 2;
        }

        $encounteredDirectionFlags{$directionFlag} = 1 if $directionFlag;

        last if(scalar(keys %encounteredDirectionFlags) > 1);
    }

    return (scalar(keys %encounteredDirectionFlags) == 2);
}

