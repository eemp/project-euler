package Utils;

use strict;
use warnings;

use Sequences qw(sum_of_sequence);
use Exporter qw(import);

our @EXPORT_OK = qw(
    sum_of_digits
    sum_of_array
    product_of_array
    get_triangle_numbers
    get_divisors
);

# expectations:
# %args = ( start => 3, end => 999, interval => 3 ); # 3, 6, ..., 999
sub sum_of_digits
{
    my $n = shift;
    my @digits = split('', $n);
    my $sum = 0;
    map { $sum += $_ } @digits;
    return $sum;
}

sub sum_of_array
{
    my @arr = @_;
    my $sum = 0;
    for(my $k = 0; $k < scalar @arr; $k++)
    {
        $sum += $arr[$k];
    }
    return $sum;
}

sub product_of_array
{
    my @arr = @_;
    my $product = 1;
    for(my $k = 0; $k < scalar @arr; $k++)
    {
        $product *= $arr[$k];
    }
    return $product;
}

sub get_triangle_numbers
{
    my %args = @_;
    my $nth = $args{n};
    my $number;
    if($nth)
    {
        $number = sum_of_sequence(
            start => 1,
            end => $nth
        );
    }
    return $number;
}

sub get_divisors
{
    my $n = shift;
    my @divisors;
    my $sqrt_n = sqrt($n);
    for(my $k = 1; $k < $sqrt_n; $k++)
    {
        if($n % $k == 0)
        {
            push(@divisors, $k);
            push(@divisors, $n / $k);
        }
    }
    if(int($sqrt_n) == $sqrt_n)
    {
        push(@divisors, $sqrt_n);
    }
    return (\@divisors, scalar @divisors);
}

