package Graph::Node;

use strict;
use warnings;

use Graph::Edge;

my $idSeq = 0;

sub new
{
    my ($class, %args) = @_;
    my $self = {
        _id => $args{id} || $idSeq++,
        _edges => {},
        _data => $args{data},
    };
    bless $self, $class;
    return $self;
}

sub id
{
    my ($self) = @_;
    return $self->{_id};
}

sub addEdge
{
    my ($self, $node, $w) = @_;
    my $newEdge = Graph::Edge->new($self, $node, $w);
    $self->{_edges}->{$node->id} = $newEdge;
}

sub removeEdge
{
    my ($self, $toNode) = @_;
    return (delete $self->{_edges}->{$toNode->id});
}

sub getEdges
{
    my ($self) = @_;
    return values %{$self->{_edges}};
}

sub getNeighbors
{
    my ($self) = @_;
    return map {$_->to} $self->getEdges;
}

1;
