#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Matrix;
use Utils qw(min);

=pod
Find smallest path sum of a given matrix from top left to bottom right, only moving right or down.
=cut

my $solution;

my $matrixFile = $ARGV[0]
    or die "Usage: $0 MATRIXFILE";
my $matrixData = [];

open(FH, $matrixFile);
while(my $rowStr = <FH>) {
    push(@$matrixData, [ split(/\s+|,/, $rowStr) ]);
}
close FH;

my $numberOfRows = scalar @$matrixData;
my $numberOfCols = scalar @{$matrixData->[0]};
my $matrix = Matrix->new($numberOfRows, $numberOfCols);

for(my $k = 0; $k < scalar @$matrixData; $k++) {
    my $row = $matrixData->[$k];
    for(my $l = 0; $l < scalar @$row; $l++) {
        $matrix->set($k+1, $l+1 => $row->[$l]); # Matrix module is not 0 indexed
    }
}

# $matrix->print();

## dynamic programming
my $dynMatrix = Matrix->new($numberOfRows, $numberOfCols);

## set the first
$dynMatrix->set(1, 1 => $matrix->get(1, 1));

## set the first col
$dynMatrix->set($_, 1 =>
    ($matrix->get($_, 1) + $dynMatrix->get($_-1, 1))) for(2..$matrix->numRows);

## set the first row
$dynMatrix->set(1, $_ =>
    ($matrix->get(1, $_) + $dynMatrix->get(1, $_-1))) for(2..$matrix->numCols);

## set the rest
for(my $k = 2; $k <= $matrix->numRows; $k++) {
    for(my $l = 2; $l <= $matrix->numCols; $l++) {
        my $currStepCost = $matrix->get($k, $l);
        my $minCost = min(
            $dynMatrix->get($k-1, $l),
            $dynMatrix->get($k, $l-1)
        ) + $currStepCost;
        $dynMatrix->set($k, $l => $minCost);
    }
}

# say "DYNAMIC PROGRAMMING MATRIX: ";
# $dynMatrix->print();

$solution = $dynMatrix->get($dynMatrix->numRows, $dynMatrix->numCols);
say "Solution = $solution" if $solution; # dev: 2427, actual: 427337

