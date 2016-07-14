package Primes;

use strict;
use warnings;

use Data::Dumper;
use Memoize;

use Utils qw(max);

use Exporter qw(import);

our @EXPORT_OK = qw(
    getPrimeFactors
    getPrimeFactors_usingPrimes
    is_prime
    get_primes
);

# first 10 primes
our $primes_list = [ qw(2 3 5 7 11 13 17 19 23 29) ];
our %primes = map {$_ => 1} @$primes_list;
our $largest_known_prime = 29;

sub is_prime
{
    my $n = shift;
    
    return $primes{$n} if($n <= $largest_known_prime);

    my $k = 3;
    my $factorUpperLimit = int(sqrt($n)) + 1; # upper limit of potential factor of $n
    
    foreach my $p (@$primes_list) {
        if($n % $p == 0) {
            return 0;
        }
        elsif($p > $factorUpperLimit) {
            $primes{$n} = 1;
            return 1;
        }
    }

    for($k = $largest_known_prime; $k < $factorUpperLimit; $k+=2)
    {
        return 0 if($n % $k == 0);
    }

    $primes{$n} = 1;
    # don't update largest_known_prime since primes prior to this were not discovered really

    return 1;
}

sub get_primes
{
    my $sieve_size;
    if(scalar @_ == 1)
    {
        ($sieve_size) = shift;
    }
    else
    {
        my %args = @_;
        $sieve_size = $args{max};
    }

    ## Erathosthenes Sieve
    my @primes = ();
    my @sieve = (0..($sieve_size+1));

    for(my $k = 2; $k < scalar @sieve; $k++)
    {
        if(defined $sieve[$k] && $sieve[$k] != 0)
        {
            push(@primes, $k);
            $primes{$k}++;
            $largest_known_prime = $largest_known_prime > $k ? $largest_known_prime : $k;

            for(my $l = $k; $l < scalar @sieve; $l+=$k)
            {
                $sieve[$l] = 0;
            }
        }
    }

    $primes_list = \@primes if($largest_known_prime <= $primes[$#primes]);

    return \@primes;
}

my %knownFactorsOfN = ();
memoize 'getPrimeFactors';
sub getPrimeFactors
{
    my ($n) = @_;

    return $knownFactorsOfN{$n} if $knownFactorsOfN{$n};

    my %factors;

    my $power;
    my $k = 2;
    my $origN = $n;
    ($n, $power) = getPowerOfFactor($n, $k);
    $factors{$k} = $power if $power;
    
    my $factorLimit = int(sqrt($n)) + 1; # upper limit of potential factor of $n
    for($k = 3; $k <= $factorLimit && $n > 1; $k+=2) {
        if(is_prime($k)) {
            ($n, $power) = getPowerOfFactor($n, $k);
            $factors{$k} = $power if $power;
        }
    }

    if($n > 1) {
        $factors{$n} = 1; # current $n is prime
    }

    $knownFactorsOfN{$origN} = \%factors;

    return \%factors;
}

sub getPrimeFactors_usingPrimes
{
    my ($n, $primes) = @_;
    
    return $knownFactorsOfN{$n} if $knownFactorsOfN{$n};
    
    my $origN = $n;
    my %factors = ();

    my $factorLimit = int(sqrt($n)) + 1; # upper limit of potential factor of $n
    for(my $k = 0; $primes->[$k] <= $factorLimit && $k < scalar @$primes; $k++) {
        my $prime = $primes->[$k];
        my $power;
        ($n, $power) = getPowerOfFactor($n, $prime);
        $factors{$prime} = $power if $power;
    }

    if($n > 1) {
        $factors{$n} = 1; # current $n is prime
    }

    $knownFactorsOfN{$origN} = \%factors;

    return \%factors;
}

memoize 'getPowerOfFactor';
sub getPowerOfFactor
{
    my ($n, $f) = @_;
    my $power = 0;
    while($n % $f == 0) { # TODO: why not just divide and compare int($val) == $val?
        $n /= $f;
        $power++;
    }
    return ($n, $power);
}

