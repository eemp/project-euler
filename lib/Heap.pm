package Heap;

use strict;
use warnings;

use Data::Dumper;

sub new
{
    my ($class, %args) = @_;
    my $self = {
        _data => [],
        _sorter => $args{sorter} || sub {
            my ($a, $b) = @_;
            return ($a->data <=> $b->data);
        }
    };
    bless $self, $class;
    return $self;
}

sub sorter
{
    my $self = shift;
    return $self->{_sorter};
}

sub push
{
    my ($self, $item) = @_;
    push(@{$self->{_data}}, $item);
}

# haha - fake it... terrible
sub pop
{
    my ($self) = @_;
    my $data = $self->{_data};
    @$data = sort { $self->sorter()->($a, $b) } @$data;
    return shift(@$data);
}

sub peek
{
    my ($self) = @_;
    my $data = $self->{_data};
    return scalar @$data;
}

sub exists
{
    my ($self, $item) = @_;

    return grep {
        $_ == $item
    } @{$self->{_data}};
}

1;

