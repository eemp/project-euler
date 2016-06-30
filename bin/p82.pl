#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Graph;
use Graph::Node;
use Heap;
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

# Create the graph
my $g = Graph->new();

## Create a fake source node
my $source = createNode(0, 0);
$g->addNode($source);

## Create nodes representing each cell
for(my $k = 1; $k <= $matrix->numRows; $k++) {
    for(my $l = 1; $l <= $matrix->numCols; $l++) {
        my $n = createNode($k, $l);
        $g->addNode($n);
    }
}

## Create edges from the source node to the nodes in the first col
for(my $k = 1; $k <= $matrix->numRows; $k++) {
    my $neighboringNode = $g->getNode(qualifyNodeId($k, 1));
    $source->addEdge($neighboringNode, 0);
}

## Link the nodes / create the edges
for(my $k = 1; $k <= $matrix->numRows; $k++) {
    for(my $l = 1; $l <= $matrix->numCols; $l++) {
        my $node = $g->getNode(qualifyNodeId($k, $l));

        ## possible directions right, up, down
        my @directions = (
            [$k-1, $l],
            [$k+1, $l],
            [$k, $l+1]
        );

        foreach my $d (@directions) {
            my $neighboringNode = $g->getNode(qualifyNodeId(@$d));
            if($neighboringNode) {
                my $cost = $matrix->get(@$d);
                $node->addEdge($neighboringNode, $cost);
            }
        }
    }
}

# Perform Dijkstra until a node representing a cell in the last col is reached

## add the source node to the heap
my $mh = Heap->new();
$source->data(0);
$mh->push($source);

while($mh->peek() && !$solution) {
    my $node = $mh->pop();
    my $nodeId = $node->id;
    my ($nodeRow, $nodeCol) = split('::', $nodeId);
    my @edges = $node->getEdges;
    
    # mark this node as discovered
    $node->marked(1);

    if($nodeCol == $matrix->numCols) {
        $solution = $node->data;
        last;
    }

    foreach my $e (@edges) {
        my $neighbor = $e->to;
        my $neighborDistance = $neighbor->data;
        my $isCloser = !$neighborDistance ||
            $neighborDistance > $node->data + $e->weight;

        if($isCloser) {
            $neighbor->data($node->data + $e->weight);
        }

        if(!$neighbor->marked && !$mh->exists($neighbor)) {
            $mh->push($neighbor);
        }
    }
}

# DONE
say "Solution = $solution" if $solution; # dev: 994, actual: 254101

sub createNode
{
    my ($r, $c) = @_;
    return Graph::Node->new(id => qualifyNodeId($r, $c));
}

sub qualifyNodeId
{
    my ($r, $c) = @_;
    return join('::', $r, $c);
}

