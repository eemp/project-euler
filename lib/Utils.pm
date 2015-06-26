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
    get_words_for_number
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

my %words_for_numbers = (
    1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven',
    8 => 'eight', 9 => 'nine', 10 => 'ten', 
    11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 15 => 'fifteen', 
    16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
    30 => 'thirty', 40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
    90 => 'ninety'
);
my %words_for_powers = (
    2 => 'hundred', # 10^2
    3 => 'thousand', # 10^3
    6 => 'million' # 10^6
);

sub get_words_for_number
{
    my ($n, $opts) = @_;
    my @words = ();
    my @digits = split('', $n);
    my $skip_and = $opts->{skip_and};
    my $return_array = $opts->{return_array};

    die 'ERROR: unhandle amount of digits passed to get_words_for_number' if(scalar @digits > 9);
    
    # min_digits - is really minimum digits required for power - 1
    foreach my $min_digits (sort {$b <=> $a} keys %words_for_powers)
    {
        my $word_for_power = $words_for_powers{$min_digits};
        if(scalar @digits > $min_digits)
        {
            my @power_digits = @digits[0..(scalar @digits - $min_digits - 1)];
            @digits = @digits[(scalar @digits - $min_digits)..$#digits];
            my @power_words = get_words_for_number(int(join('', @power_digits)), 
                { return_array => 1, skip_and => 1 });
            push(@words, @power_words) if scalar @power_words;
            push(@words, $word_for_power) if scalar @power_words; 
        }
    }

    my $tens_leftover = int(join('', @digits));
    
    if($tens_leftover > 0)
    {
        if(scalar @words && !$skip_and)
        {
            push(@words, 'and');
        }

        ## at this point @digits represents something < 10^2
        if($tens_leftover <= 20)
        {
            push(@words, $words_for_numbers{$tens_leftover});
        }
        else
        {
            my $ones_rep = $tens_leftover % 10;
            my $tens_rep = $tens_leftover - $ones_rep;
            push(@words, $words_for_numbers{$tens_rep});
            push(@words, $words_for_numbers{$ones_rep}) if $ones_rep != 0;
        }
    }
    
    return $return_array ? @words : join(' ', @words);
}


