package Fibonacci;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    get_fibonacci_sequence
);

sub get_fibonacci_sequence
{
    my (%args) = @_;
    my $n1 = $args{first} || 1;
    my $n2 = $args{second} || 2;
    my $max_n = $args{max_n};
    my $max_value = $args{max_value};
    my @seq = ($n1, $n2);

    do {
        push(@seq, $seq[$#seq] + $seq[$#seq-1]);
    } while (($max_n && scalar @seq < $max_n) || ($max_value && $seq[$#seq] + $seq[$#seq-1] < $max_value));

    return \@seq;
}

