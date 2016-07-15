package ProductChain;

use strict;
use warnings;

use Data::Dumper;

use Primes qw(getPrimeFactors);

sub new
{
    my ($class, @multipliers) = @_;
    
    my $self = {
        _multipliers => { map {$_ => 1} (@multipliers) },
        _divisors => {}
    };
    bless $self, $class;

    $self->expandMultipliers();

    return $self;
}

sub multipliers
{
    my ($self, $multipliers) = @_;
    $self->{_multipliers} = $multipliers if $multipliers;
    return $self->{_multipliers};
}

sub divisors
{
    my ($self, $divisors) = @_;
    $self->{_divisors} = $divisors if $divisors;
    return $self->{_divisors};
}

sub expandMultipliers
{
    my ($self) = @_;
    my @multipliers = keys %{$self->multipliers};
    my %multipliers = ();
    foreach my $m (@multipliers) {
        my $factors = getPrimeFactors($m);
        foreach my $f (keys %$factors) {
            $multipliers{$f} += $factors->{$f};
        }
    }
    $self->multipliers(\%multipliers);
}

sub reduceByAnotherProductChain
{
    my ($self, $other) = @_;

    my $multipliers = $self->multipliers;
    my $divisors = $self->divisors;
    my $otherMultipliers = $other->multipliers;

    foreach my $om (keys %$otherMultipliers) {
        my $power = $multipliers->{$om} || 0;
        my $otherPower = $otherMultipliers->{$om};
        my $difference = $power - $otherPower;

        if($difference > 0) {
            $multipliers->{$om} = $difference;
        }
        elsif($difference < 0) {
            delete $multipliers->{$om};
            $divisors->{$om} = -$difference;
        }
        else {
            delete $multipliers->{$om};
        }
    }
}

sub value
{
    my ($self) = @_;
    my $value = 1;
    my $multipliers = $self->multipliers;
    my $divisors = $self->divisors;
    foreach my $m (keys %$multipliers) {
        $value *= ($m ** $multipliers->{$m});
    }
    foreach my $d (keys %$divisors) {
        $value /= ($d ** $divisors->{$d});
    }
    return $value;
}

return 1;

