package Sequences;

use strict;
use warnings;
no warnings 'recursion';

use Exporter qw(import);

our @EXPORT_OK = qw(
    sum_of_sequence
    get_collatz_sequence_size
    get_triangle_numbers
);
# some are technically not sequences in the mathematical sense

# expectations:
# %args = ( start => 3, end => 999, interval => 3 ); # 3, 6, ..., 999
sub sum_of_sequence
{
    my (%args) = @_;
    my $s = $args{start};
    my $e = $args{end};
    my $t = $args{interval} || 1;
    my $median = ($s + $e)/2;
    my $num_of_terms = ($e-$s)/$t + 1;
    return $median * $num_of_terms;
}

our $collatz_cache = { 1 => 1 };
sub get_collatz_sequence_size
{
    my $n = shift;
    return $collatz_cache->{$n} if($collatz_cache->{$n});

    my $prev = $n;
    my $next = $prev % 2 == 0 ? 
        $prev/2 :
        $prev*3 + 1
    ;
    my $seq_size = get_collatz_sequence_size($next) + 1;
    $collatz_cache->{$n} = $seq_size;
    return $seq_size;
}

sub get_triangle_numbers
{
    my (%args) = @_;
    
    my $n = $args{n};
    my $maxn = $args{max_n};

    if(!$n && !$maxn)
    {
        die 'ERROR: invalid use of get_triangle_numbers - supply either n or max_n params';
    }

    return ($n*($n+1)/2) if defined $n;

    my @numbers = ();
    # n*(n+1) / 2
    for($n = 1; $n <= $maxn; $n++)
    {
        push(@numbers, $n*($n+1)/2);
    }

    return \@numbers;
}

