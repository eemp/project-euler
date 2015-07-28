package Fraction;

use strict;
use warnings;

use Utils qw(gcd); 

sub new
{
    my ($class, $numerator, $denominator, %args) = @_;

    return undef if (!$numerator || !$denominator);
    # die 'ERROR: numerator and denominator must be specified in order to create a new Fracion' if (!$numerator || !$denominator);

    my $self = {
        _n => $numerator,
        _d => $denominator,
        %args
    };
    bless $self, $class;

    $self->reduce() if $args{auto_reduce};
    
    return $self;
}

sub auto_reduce
{
    my ($self, $flag) = @_;
    $self->{auto_reduce} = $flag if $flag;
    return $self->{auto_reduce};
}

sub numerator
{
    my ($self, $numerator) = @_;
    $numerator = $numerator ? $numerator : $self->{_n};
    return ($self->{_n} = $numerator);
}

sub denominator
{
    my ($self, $denominator) = @_;
    $denominator = $denominator ? $denominator : $self->{_d};
    return ($self->{_d} = $denominator);
}

sub reduce
{
    my $self = shift;
    my $numerator = $self->numerator;
    my $denominator = $self->denominator;
    my $gcd = gcd($numerator, $denominator);
    $self->numerator($numerator/$gcd);
    $self->denominator($denominator/$gcd);
}

sub equals
{
    my ($self, $other) = @_;
    return 0 if !$other;
    return ($self->numerator * $other->denominator == $self->denominator * $other->numerator);
}

sub multiply
{
    my ($self, $other) = @_;
    return if !$other;
    $self->numerator($self->numerator*$other->numerator);
    $self->denominator($self->denominator*$other->denominator);
    $self->reduce() if $self->auto_reduce();
}

return 1;

