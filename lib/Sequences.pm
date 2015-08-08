package Sequences;

use strict;
use warnings;
no warnings 'recursion';

use Exporter qw(import);

our @EXPORT_OK = qw(
    sum_of_sequence
    get_collatz_sequence_size
    get_triangle_numbers
    get_pentagonal_numbers
    get_hexagonal_numbers
    is_sequence
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

sub get_triangle_number_n
{
    my $n = shift;
    return ($n*($n+1)/2);
}

sub get_pentagonal_number_n
{
    my $n = shift;
    return ($n*(3*$n-1)/2);
}

sub get_hexagonal_number_n
{
    my $n = shift;
    return ($n*(2*$n-1));
}

sub get_triangle_numbers
{
    return get_tph_numbers(@_, fn => \&get_triangle_number_n);
}

sub get_pentagonal_numbers
{
    return get_tph_numbers(@_, fn => \&get_pentagonal_number_n);
}

sub get_hexagonal_numbers
{
    return get_tph_numbers(@_, fn => \&get_hexagonal_number_n);
}

sub get_tph_numbers
{
    my (%args) = @_;
    
    my $n = $args{n};
    my $minn = $args{min_n} || 1;
    my $maxn = $args{max_n};
    my $formulaFn = $args{fn};

    if(!$n && !$maxn)
    {
        die "ERROR: invalid use of get_(tri/pent/hex)_numbers - supply either n or max_n params";
    }

    return $formulaFn->($n) if defined $n;

    my @numbers = ();
    # n*(n+1) / 2
    for($n = $minn; $n <= $maxn; $n++)
    {
        push(@numbers, $formulaFn->($n));
    }

    return \@numbers;
}

sub is_sequence
{
    my (@seq) = @_;
    my $step = $seq[1] - $seq[0];
    for(my $k = 0; $k < scalar @seq - 1; $k++)
    {
        return 0 if($step != $seq[$k+1] - $seq[$k]);
    }
    return 1;
}

