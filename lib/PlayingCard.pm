package PlayingCard;

use Exporter qw(import);

use constant DIAMONDS   => 1;
use constant CLUBS      => 2;
use constant HEARTS     => 3;
use constant SPADES     => 4;

use constant JACK       => 11;
use constant QUEEN      => 12;
use constant KING       => 13;
use constant ACE        => 14;

our @EXPORT_OK = qw(
    DIAMONDS
    CLUBS
    HEARTS
    SPADES

    JACK
    QUEEN
    KING
    ACE
);

sub new
{
    my ($class, $cardstr, $num) = @_;
    
    my ($color, $value);
    if($num)
    {
        $value = $num;
        $color = $cardstr;
    }
    else
    {
        ($value, $color) = _parse_card_str($cardstr);
    }

    my $self = {
        _val => $value,
        _col => $color
    };
    bless $self, $class;

    return $self;
}

sub _parse_card_str
{
    my $str = shift;
    my $num = substr($str, 0, 1);
    my $color = substr($str, 1, 1);
   
    my %valMapping = (T => 10, J => JACK, Q => QUEEN, K => KING, A => ACE);
    my %colMapping = (S => SPADES, H => HEARTS, C => CLUBS, D => DIAMONDS); 

    if($num !~ m{^\d$})
    {
        if($valMapping{$num}) {
            $num = $valMapping{$num};
        } else {
            die "ERROR: Unrecognized card : $str (What's the value ($num?)?)";
        }
    }

    if($colMapping{$color}) {
        $color = $colMapping{$color};
    }
    else {
        die "ERROR: Unrecognized card : $str (What's the color ($color?)?)";
    }

    return ($num, $color);
}

sub color
{
    my ($self, $col) = shift;
    return ($self->{_col} = $col ? $col : $self->{_col});
}

sub number
{
    my ($self, $val) = shift;
    return ($self->{_val} = $val ? $val : $self->{_val});
}

