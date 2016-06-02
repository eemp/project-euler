package Graph::Edge;

use strict;
use warnings;

my $idSeq = 0;

sub new
{
    my ($class, $from, $to, $w) = @_;
    my $self = {
        _id => $idSeq++,
        _from => $from,
        _to => $to,
        _w => $w,
    };
    bless $self, $class;
    return $self;
}

sub from
{
    my ($self) = @_;
    return $self->{_from};
}

sub to
{
    my ($self) = @_;
    return $self->{_to};
}

sub weight
{
    my ($self) = @_;
    return $self->{_w};
}

1;
