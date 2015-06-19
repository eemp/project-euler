package Utils;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    sum_of_digits
    product_of_array
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

