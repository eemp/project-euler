#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../../lib";
use Utils qw(get_combinations);

my @arr = (1, 2, 3, 4, 5);

say "[ " . join(", ", @arr) . " ] choose 3\n";

my $combinations = get_combinations(3, @arr);

foreach my $c (@$combinations) {
    say join(", ", @$c);
}



@arr = (1, 2, 3);

say "\n[ " . join(", ", @arr) . " ] choose 3\n";

$combinations = get_combinations(3, @arr);

foreach my $c (@$combinations) {
    say join(", ", @$c);
}



@arr = (1, 2, 3);

say "\n[ " . join(", ", @arr) . " ] choose 4\n";

$combinations = get_combinations(4, @arr);

foreach my $c (@$combinations) {
    say join(", ", @$c);
}


