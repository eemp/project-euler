package Graph;

use strict;
use warnings;

use Graph::Node;

sub new
{
    my ($class, %args) = @_;
    my $self = {
        _nodes => {},
        _isUndirected => $args{undirected},
    };
    bless $self, $class;
    return $self;
}

sub getNode
{
    my ($self, $id) = @_;
    return $self->{_nodes}->{$id};
}

sub getNodes
{
    my ($self) = @_;
    return values %{$self->{_nodes}};
}

sub addNode
{
    my ($self, $newNode) = @_;
    
    if(ref $newNode eq 'Graph::Node') {
        $self->{_nodes}->{$newNode->id} = $newNode;
    }
    elsif(ref $newNode eq 'HASH') {
        $newNode = Graph::Node->new(%$newNode);
        $self->{_nodes}->{$newNode->id} = $newNode;
    }
    else {
        die 'Not sure how to create a node from ' . Dumper $newNode;
    }
    
    return $newNode;
}

sub removeNode
{
    my ($self, $node) = @_;
    return undef if(ref $node ne 'Graph::Node');
    
    my @nodes = $self->getNodes;
    foreach my $n (@nodes) {
        $n->removeEdge($node);
    }
    
    return (delete $self->{_nodes}->{$node->id});
}

sub addEdge
{
    my ($self, $from, $to) = @_;
    $from->addEdge($to);
    $to->addEdge($from) if($self->{_isUndirected});
}

1;
