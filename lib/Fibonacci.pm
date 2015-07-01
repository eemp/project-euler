package Fibonacci;

use strict;
use warnings;

use Utils qw(sum_array_refs_of_numbers);
use Exporter qw(import);

our @EXPORT_OK = qw(
    get_fibonacci_sequence
    get_first_in_sequence
);

## meant for returning initial elements of the sequence
## elements are not yet large!
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

## return the first element in the sequence that matches a condition
## elements are expected to get large and therefore represented as arrays
sub get_first_in_sequence
{
    my (%args) = @_;
    my $n1 = $args{first} || 1;
    my $n2 = $args{second} || 2;
    my $end_def = $args{end};
    
    die 'ERROR: unexpected use of get_first_in_sequence - must supply a sub ref used to check when this subroutine should terminate' if !$end_def;

    my $prev = [split('', $n1)];
    my $curr = [split('', $n2)];
    my $next;
    my $index = 2;
    while(!&$end_def($curr))
    {
        $next = sum_array_refs_of_numbers($prev, $curr);
        $prev = $curr;
        $curr = $next;
        $index++;
    }

    return ($index, $curr);
}

