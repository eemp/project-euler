package Primes;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    get_largest_prime_factor
    get_prime_factors
    get_prime_factors_hashref
    is_prime
    get_primes
);

sub get_largest_prime_factor
{
    my $n = shift;
    my $factors = get_prime_factors($n);
    return $factors->[$#$factors];
}

sub get_prime_factors_hashref
{
    my $n = shift;
    my $factors = {};
    map { $factors->{$_}++ } @{get_prime_factors($n)};
    return $factors;
}

sub get_prime_factors
{
    my $n = shift;
    my $factor_product = 1;
    my $k = 2;
    my @factors = ();

    while($n % 2 == 0)
    {
        $n /= 2;
        push(@factors, 2);
    }

    $k++;
    while($factor_product < $n)
    {
        if(is_prime($k))
        {
            while($n % $k == 0)
            {
                $n /= $k;
                push(@factors, $k);
            }
        }
        $k+=2;
    }
    return \@factors;
}

# first 10 primes
our %primes = map {$_ => 1} qw(2 3 5 7 11 13 17 19 23 29);
our $largest_known_prime = 29;
sub is_prime
{
    my $n = shift;

    return $primes{$n} if($n < $largest_known_prime);
    return 0 if $n % 2 == 0;

    my $k = 3;
    my $factor_uplimit = int(sqrt($n)) + 1; # upper limit of potential factor of $n
    for($k = 3; $k < $factor_uplimit; $k+=2)
    {
        return 0 if($n % $k == 0);
    }

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
    my @sieve = (0..$sieve_size);

    for(my $k = 2; $k < scalar @sieve; $k++)
    {
        if(defined $sieve[$k] && $sieve[$k] != 0)
        {
            push(@primes, $k);
            for(my $l = $k; $l < scalar @sieve; $l+=$k)
            {
                $sieve[$l] = 0;
            }
        }
    }

    return \@primes;
}

