#!/usr/bin/perl

use strict;
use warnings;

use feature qw(say);
use Data::Dumper;

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Primes qw(get_primes is_prime);
use Utils qw(get_combinations);

use Graph;
use Graph::Node;

=pod
Prime pair sets
The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
=cut

### what we can do instead
# is form a graph
# where each node is a prime
# each edge connects two primes that can be
# concatenated to form a larger prime 

### looking for a subgraph such that
# each prime in the subgraph is connected to every
# other prime in the subgraph
# and there are atleast n nodes in the subgraph
# in the example, n = 4, for our case, n = 5

### how do you look for such a subgraph?
# start by eliminating the nodes that 
# have less than n - 1 edges, keep repeating


my $solution;

my $SET_SIZE = 4;
my $PRIMES_CAP = 1_000_000;
my $primes = get_primes($PRIMES_CAP);
my $small_primes = get_primes(1_000);

warn 'Got the primes...';

my %primePairs = ();
# only record higher primes for each key prime

# $p1k = 1 skips the first prime (2)
for(my $p1k = 1; $p1k < scalar @$small_primes; $p1k++) {
    my $p1 = $small_primes->[$p1k];
    ## skip the obvious ones
    next if($p1 == 5);
        
    $primePairs{$p1} = {};
        
    for(my $p2k = $p1k+1; $p2k < scalar @$small_primes; $p2k++) {
        my $p2 = $small_primes->[$p2k];
        
        ## skip the obvious ones
        next if($p2 == 5);
        
        if(is_prime(concat($p1, $p2)) && is_prime(concat($p2, $p1))) {
            $primePairs{$p1}->{$p2} = 1;
        }
    }
}

warn 'Finished pairing the primes...';

my @processedPrimes = sort { $a <=> $b } keys %primePairs;

foreach my $p (@processedPrimes) {
    my @linkedPrimes = keys %{$primePairs{$p}};
    my $g = Graph->new(undirected => 1);
    
    my $pn = create_node($p);
    $g->addNode($pn);

    foreach my $s (@linkedPrimes) {
        my $sn = create_node($s);
        $g->addNode($sn);
        # $g->addEdge($pn, $sn);
    }

    my @nodes = $g->getNodes;
    for(my $k = 0; $k < scalar @nodes; $k++) {
        for(my $l = $k+1; $l < scalar @nodes; $l++) {
            my $kn = $nodes[$k];
            my $ln = $nodes[$l];
            my $knp = $kn->id;
            my $lnp = $ln->id;
            my $isPair = $primePairs{$knp}->{$lnp} ||
                $primePairs{$lnp}->{$knp};

            $g->addEdge($kn, $ln) if $isPair;
        }
    }

    ## keep removing nodes that do not pair well
    my $removedNode = 1;
    while(defined $removedNode) {
        $removedNode = undef;
        @nodes = $g->getNodes;

        foreach my $n (@nodes) {
            my $totalNeighbors = $n->getNeighbors;
            if($totalNeighbors < $SET_SIZE - 1) {
                $g->removeNode($n);
                $removedNode = $n;
            }
        }
    }

    my @candidates = map {$_->id} $g->getNodes;
    my $combinations = get_combinations($SET_SIZE, @candidates);
    foreach my $c (@$combinations) {
        if(is_valid_set(@$c)) {
            warn Dumper $c;
        }
    }
}

say "Solution = $solution" if $solution; #  

sub create_node
{
    my ($p) = @_;
    return Graph::Node->new(id => $p);
}

sub is_valid_set
{
    my @set = @_;
    for(my $k = 0; $k < scalar @set; $k++) {
        for(my $l = $k+1; $l < scalar @set; $l++) {
            my ($m, $n) = ($set[$k], $set[$l]);
            if(!(is_prime(concat($m, $n)) && is_prime(concat($n, $m)))) {
                return 0;
            }
        }
    }

    return 1;
}

sub concat
{
    my ($p1, $p2) = @_;
    return int("$p1$p2");
}

