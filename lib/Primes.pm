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

# first 10 primes
our $primes_list = [ qw(2 3 5 7 11 13 17 19 23 29) ];
our %primes = map {$_ => 1} @$primes_list;
our $largest_known_prime = 29;
sub is_prime
{
    my $n = shift;

    return $primes{$n} if($n < $largest_known_prime);
    return 0 if $n < 2;
    return 0 if $n % 2 == 0;

    my $k = 3;
    my $factor_uplimit = int(sqrt($n)) + 1; # upper limit of potential factor of $n
    for($k = 3; $k < $factor_uplimit; $k+=2)
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
    my @sieve = (0..$sieve_size);

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

    $primes_list = \@primes if($largest_known_prime == $primes[$#primes]);

    return \@primes;
}

sub get_largest_prime_factor
{
    my $n = shift;
    my $factors = get_prime_factors($n);
    return $factors->[$#$factors];
}

sub get_prime_factors_hashref
{
    my $n = shift;
    return get_prime_factors($n, 1);
}

sub get_prime_factors
{
    my $n = shift;
    my $hashref = shift;
    my $k = 2;
    my @factors = ();
    my %factors = ();

    if($largest_known_prime > $n)
    {
        if($primes{$n})
        {
            push(@factors, $n);
            $factors{$n}++;
        }
        else
        {
            for(my $k = 0; $k < scalar @$primes_list; $k++)
            {
                my $p = $primes_list->[$k];
                while($n % $p == 0)
                {
                    $n /= $p;
                    push(@factors, $p);
                    $factors{$p}++;
                }
                last if $n == 1;
            }
        }
    }
    else
    {
        while($n % 2 == 0)
        {
            $n /= 2;
            push(@factors, 2);
            $factors{$k}++;
        }

        $k++;
        while($n > 1)
        {
            my $is_prime = ($k <= $largest_known_prime && $primes{$k}) || ($k > $largest_known_prime && is_prime($k));
            
            if($is_prime)
            {
                while($n % $k == 0)
                {
                    $n /= $k;
                    push(@factors, $k);
                    $factors{$k}++;
                }
            }
            $k+=2;
        }
    }

    return $hashref ? \%factors : \@factors;
}


