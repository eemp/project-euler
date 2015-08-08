package PokerHands;

use strict;
use warnings;

use Data::Dumper;
use Sequences qw(is_sequence);
use PlayingCard qw(ACE);

use Exporter qw(import);
our @EXPORT_OK = qw(compare_poker_hands);

use constant HIGH_CARD  => 1;
use constant ONE_PAIR   => 2;
use constant TWO_PAIRS  => 3;
use constant TRIPLE     => 4;
use constant STRAIGHT   => 5;
use constant FLUSH      => 6;
use constant FULL_HOUSE => 7;
use constant BOMB       => 8;
use constant STFLUSH    => 9;
use constant RYL_FLUSH  => 10;

sub compare_poker_hands
{
    my ($h1, $h2) = @_;
    my $r1 = get_poker_hand_rank($h1);
    my $r2 = get_poker_hand_rank($h2);
    
    my $rcmp = ($r1 <=> $r2);
    return $rcmp if $rcmp != 0;

    if($r1 == ONE_PAIR || $r1 == TWO_PAIRS || $r1 == TRIPLE || $r1 == BOMB)
    {
        my $dup_fn_map = {
            ONE_PAIR()  => \&get_doubles,
            TWO_PAIRS() => \&get_doubles,
            TRIPLE()  => \&get_triple,
            BOMB()  => \&get_quadruple,
        };
        my $dup_fn = $dup_fn_map->{$r1};
        my $dh1 = $dup_fn->($h1);
        my $dh2 = $dup_fn->($h2);
        for(my $k = 0; $k < scalar @$dh1; $k++)
        {
            my ($d1, $d2) = ($dh1->[$k], $dh2->[$k]);
            $rcmp = ($d1->[0]->number <=> $d2->[0]->number);
            return $rcmp if $rcmp != 0;
        }
        return compare_highcards($h1, $h2);
    }
    elsif($r1 == FULL_HOUSE)
    {
        ## compare the triples
        my $th1 = get_triple($h1);
        my $th2 = get_triple($h2);
        $rcmp = ($th1->[0]->[0]->number <=> $th2->[0]->[0]->number);
        return $rcmp if $rcmp != 0;

        ## compare the doubles
        my $dh1 = get_doubles($h1);
        my $dh2 = get_doubles($h2);
        $rcmp = ($dh1->[0]->[0]->number <=> $dh2->[0]->[0]->number);
        return $rcmp if $rcmp != 0;
    }
    # elsif($r1 == RYL_FLUSH || $r1 == STFLUSH || $r1 == FLUSH || $r1 == STRAIGHT || $r1 == HIGH_CARD)
    # {
    #     return compare_highcards($h1, $h2);
    # }

    return compare_highcards($h1, $h2);
}

sub compare_highcards
{
    my ($h1, $h2) = @_;
    my $sh1 = [ sort { $b->number <=> $a->number } @$h1 ];
    my $sh2 = [ sort { $b->number <=> $a->number } @$h2 ];

    for(my $k = 0; $k < scalar @$sh1; $k++)
    {
        my $rcmp = ($sh1->[$k]->number <=> $sh2->[$k]->number);
        return $rcmp if $rcmp != 0;
    }
    
    $sh1 = [ sort { $b->color <=> $a->color } @$h1 ];
    $sh2 = [ sort { $b->color <=> $a->color } @$h2 ];

    for(my $k = 0; $k < scalar @$sh1; $k++)
    {
        my $rcmp = ($sh1->[$k]->color <=> $sh2->[$k]->color);
        return $rcmp if $rcmp != 0;
    }
    
    return 0;
}

sub get_poker_hand_rank
{
    my $hand = shift;
    
    die "ERROR: Unexpected number of cards in hand (" . scalar @$hand . ")" if (scalar @$hand != 5);

    my %props = (
        RYL_FLUSH()     => is_rylflush($hand),
        STFLUSH()       => is_stflush($hand),
        BOMB()          => is_bomb($hand),
        FULL_HOUSE()    => is_house($hand),
        FLUSH()         => is_flush($hand),
        STRAIGHT()      => is_straight($hand),
        TRIPLE()        => is_triple($hand),
        TWO_PAIRS()     => is_twopairs($hand),
        ONE_PAIR()      => is_onepair($hand)
    );
   
    return RYL_FLUSH if ($props{RYL_FLUSH()});
    return STFLUSH if ($props{STFLUSH()});
    return BOMB if ($props{BOMB()});
    return FULL_HOUSE if ($props{FULL_HOUSE()});
    return FLUSH if $props{FLUSH()};
    return STRAIGHT if $props{STRAIGHT()};
    return TRIPLE if $props{TRIPLE()};
    return TWO_PAIRS if $props{TWO_PAIRS()};
    return ONE_PAIR if $props{ONE_PAIR()};

    return HIGH_CARD;
}

sub is_rylflush
{
    my $hand = shift;
    my $is_stflush = is_stflush($hand);
    my $high_card = get_highcard($hand);
    my $rv = $is_stflush && $high_card->number == ACE;
    # warn "ROYAL FLUSH : " . Dumper $hand if $rv;
    return $rv;
}

sub is_stflush
{
    my $hand = shift;
    my $is_straight = is_straight($hand);
    my $is_flush = is_flush($hand);
    my $rv = $is_flush && $is_flush;
    # warn "STRAIGHT FLUSH : " . Dumper $hand if $rv;
    return $rv;
}

sub is_bomb
{
    my $hand = shift;
    my %vals = ();
    foreach my $c (@$hand) { $vals{$c->number}++;}
    my @vals = values %vals;
    my $rv = grep { $_ == 4 } @vals;
    # warn "BOMB : " . Dumper $hand if $rv;
    return $rv;
}

sub is_house
{
    my $hand = shift;
    my %vals = ();
    foreach my $c (@$hand) { $vals{$c->number}++;}
    my @vals = values %vals;
    my $rv = (scalar @vals == 2 && grep { $_ == 3 } @vals) ? 1 : 0;
    # warn "FULL HOUSE : " . Dumper $hand if $rv;
    return $rv;
}

sub is_flush
{
    my $hand = shift;
    my %cols = map { $_->color => 1 } @$hand;
    my $rv = scalar(keys %cols) == 1 ? 1 : 0;
    return $rv;
}

sub is_straight
{
    my $hand = shift;
    my @vals = map { $_->number } @$hand;
    @vals = sort { $a <=> $b } @vals;
    my $rv = is_sequence(@vals, $vals[$#vals]+1); # ensure its consecutive numbers sequence and not just any seq (2,4,6,8,10)
    # warn "STRAIGHT : " . Dumper $hand if $rv;
    return $rv;
}

sub is_triple
{
    my $hand = shift;
    my $triples = get_triple($hand);
    my $rv = scalar @$triples == 1 ? 1 : 0;
    # warn "TRIPLE : " . Dumper $hand if $rv;
    return $rv;
}

sub is_twopairs
{
    my $hand = shift;
    my $doubles = get_doubles($hand);
    my $rv = scalar @$doubles == 2 ? 1 : 0;
    # warn "TWO PAIRS : " . Dumper $hand if $rv;
    return $rv;
}

sub is_onepair
{
    my $hand = shift;
    my $doubles = get_doubles($hand);
    my $rv = scalar @$doubles == 1 ? 1 : 0;
    # warn "ONE PAIR : " . Dumper $hand if $rv;
    return $rv;
}


sub get_highcard
{
    my $hand = shift;
    my $highcard = undef;
    foreach my $c (@$hand)
    {
        if(!$highcard || $c->number > $highcard->number)
        {
            $highcard = $c;
        }
    }
    return $highcard;
}

sub get_doubles
{
    my $hand = shift;
    return get_duplicates($hand, 2);
}

sub get_triple
{
    my $hand = shift;
    return get_duplicates($hand, 3);
}

sub get_quadruple
{
    my $hand = shift;
    return get_duplicates($hand, 4);
}

sub get_duplicates
{
    my ($hand, $dup_amount) = @_;
    my @desired_dups = ();
    my $numbers_seen;
    map { push(@{$numbers_seen->{$_->number}}, $_) } @$hand;
    foreach my $num (keys %$numbers_seen)
    {
        my $dups = $numbers_seen->{$num};
        if(scalar @$dups == $dup_amount)
        {
            push(@desired_dups, $dups);
        }
    }
    
    if(scalar @desired_dups > 1)
    {
        @desired_dups = sort { $b->[0]->number <=> $a->[0]->number } @desired_dups;
    }

    return \@desired_dups;
}

1;

