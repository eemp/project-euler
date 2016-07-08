package LargeNumber;

use strict;
use warnings;

use Data::Dumper;

use Utils qw(max get_digits); 

sub new
{
    my ($class, $digits, %args) = @_;
    
    return undef if (!defined $digits);

    if(ref $digits ne 'ARRAY') {
        $digits = [reverse(@{get_digits($digits)})];
    }
    else {
        $digits = [$args{skip_reverse} ? @$digits : reverse(@$digits)];
    }

    my $self = {
        _n => $digits,
    };
    bless $self, $class;

    return $self;
}

sub digits
{
    my ($self) = @_;
    return $self->{_n};
}

sub equals
{
    my ($self, $other) = @_;
    my $digits = $self->digits;
    my $otherDigits = $other->digits;

    if(scalar @$digits != scalar @$otherDigits) {
        return 0;
    }
    for(my $k = 0; $k < scalar @$digits; $k++) {
        my $dig = $digits->[$k];
        my $otherDig = $otherDigits->[$k];
        return 0 if $dig != $otherDig;
    }

    return 1;
}

sub lshift
{
    my ($self, $amount) = @_;
    my $result = LargeNumber->new($self->digits, skip_reverse => 1);
    if($amount) {
        unshift(@{$result->{_n}}, (0) x $amount);
    }
    return $result;
}

sub add
{
    my ($self, $other) = @_;
    my $digits = $self->digits;
    my $otherDigits = $other->digits;
    my $maxDigits = max(scalar @$digits, scalar @$otherDigits);
    my @sum = ();
    my $carry = 0;
    for(my $k = 0; $k < $maxDigits; $k++) {
        my $dig = $digits->[$k] || 0;
        my $otherDig = $otherDigits->[$k] || 0;
        my $digSum = $dig + $otherDig + $carry;
        my $nextDig = $digSum % 10;
        
        $carry = int($digSum/10);
        push(@sum, $nextDig);
    }
    push(@sum, $carry > 10 ? ($carry % 10, int($carry/10)) : $carry)
        if $carry > 0;
    return LargeNumber->new(\@sum, skip_reverse => 1);
}

sub multiply
{
    my ($self, $other) = @_;
    my $otherDigits = $other->digits;
    my @list = ();
    my $amountToLShift = 0;
    foreach my $dig (@$otherDigits) {
        push(@list, $self->_multiplyBySingleDigit($dig)->lshift($amountToLShift++));
    }
    return __PACKAGE__->sum(@list);
}

sub pow
{
    my ($self, $exp) = @_; # $exp is expected to be scalar
    my $result = LargeNumber->new($self->digits, skip_reverse => 1);
    for(my $k = 1; $k < $exp; $k++) {
        $result = $result->multiply($self);
    }
    return $result;
}

sub toString
{
    my ($self) = @_;
    my $digits = $self->digits;
    return join('', reverse(@$digits));
}

### SOME HELPERS

sub _multiplyBySingleDigit
{
    my ($self, $otherDig) = @_;
    my @result = ();
    my $digits = $self->digits;
    my $carry = 0;
    foreach my $dig (@$digits) {
        my $prodSum = $dig * $otherDig + $carry;
        my $nextDig = $prodSum % 10;
        $carry = int($prodSum/10);
        push(@result, $nextDig);
    }
    push(@result, $carry > 10 ? ($carry % 10, int($carry/10)) : $carry)
        if $carry > 0;
    return LargeNumber->new(\@result, skip_reverse => 1);
}

### STATIC METHODS

sub sum
{
    my ($self, @largeNumbers) = @_;
    my $sum = LargeNumber->new(0);
    foreach my $lNum (@largeNumbers) {
        $sum = $sum->add($lNum);
    }
    return $sum;
}

return 1;

