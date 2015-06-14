package Primes;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    get_prime_factors
    is_prime
);

sub get_largest_prime_factor
{
    my $n = shift;
    my $factors = get_prime_factors($n);
    return $factors[$#$factors];
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

