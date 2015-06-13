package Sequences;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    sum_of_sequence
);

# expectations:
# %args = ( start => 3, end => 999, interval => 3 ); # 3, 6, ..., 999
sub sum_of_sequence
{
    my (%args) = @_;
    my $s = $args{start};
    my $e = $args{end};
    my $t = $args{interval};
    my $median = ($s + $e)/2;
    my $num_of_terms = ($e-$s)/$t + 1;
    return $median * $num_of_terms;
}

