#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use FindBin qw($Bin);
use Data::Dumper;

use lib "$Bin/../lib";
use Primes qw(get_primes);
use Utils qw(sum_of_array);

=pod
The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
=cut

my $solution;
my $STEP_SIZE = 1_000_000;
my $step = $STEP_SIZE;
my @truncatable_primes = ();

while(scalar @truncatable_primes != 11 && $step < 10_000_000)
{
    @truncatable_primes = ();
    my $primes_list = get_primes(max => $step);
    my %primes = map { $_ => 1 } @$primes_list;

    foreach my $p (@$primes_list)
    {
        my $truncations = get_truncations($p);
        if($truncations)
        {
            my $truncatable_flag = 1;
            foreach my $t (@$truncations)
            {
                $truncatable_flag = 0 if(!$primes{$t});
            }

            push(@truncatable_primes, $p) if $truncatable_flag;
        }
    }

    $step += $STEP_SIZE;
}

$solution = sum_of_array(@truncatable_primes);
say "Solution = $solution" if $solution; # 748317 

sub get_truncations
{
    my $n = shift;
    my $len = length($n);
    return undef if $len == 1;
    my %truncations = ();
    for(my $k = 0; $k < $len; $k++)
    {
        $truncations{substr($n, 0, $k+1)} = 1;
        $truncations{substr($n, $k)} = 1;
    }

    return [ keys %truncations ];
}

