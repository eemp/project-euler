package Calendar;

use strict;
use warnings;

use Exporter qw(import);

our @EXPORT_OK = qw(
    is_leap_year
    get_next_date
    get_date_string
    SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY SATURDAY
);

use constant SUNDAY     => 1;
use constant MONDAY     => 2;
use constant TUESDAY    => 3;
use constant WEDNESDAY  => 4;
use constant THURSDAY   => 5;
use constant FRIDAY     => 6;
use constant SATURDAY   => 7;

use constant JANUARY    => 1;
use constant FEBRUARY   => 2;
use constant MARCH      => 3;
use constant APRIL      => 4;
use constant MAY        => 5;
use constant JUNE       => 6;
use constant JULY       => 7;
use constant AUGUST     => 8;
use constant SEPTEMBER  => 9;
use constant OCTOBER    => 10;
use constant NOVEMBER   => 11;
use constant DECEMBER   => 12;


use constant THIRTY_DAY_MONTHS => { map { $_ => 1 } (
    APRIL,
    JUNE,
    SEPTEMBER,
    NOVEMBER
) };

sub is_leap_year
{
    my $year = shift;
    my $is_leap = $year % 4 == 0 ? 1 : 0;
    $is_leap = $year % 100 == 0 ? 0 : $is_leap;
    $is_leap = $year % 400 == 0 ? 1 : $is_leap;
    return $is_leap;
}

sub get_next_date
{
    my ($year, $month, $date, $day) = @_;
    my $omonth = $month; # original month
    $day = get_next_day($day);
    $date = $date + 1;
    if($date > 31)
    {
        $date = 1;
        $month = get_next_month($month);
        $year++ if ($month == JANUARY && $omonth != $month);
    }
    elsif($date > 30 && THIRTY_DAY_MONTHS()->{$month})
    {
        $date = 1;
        $month = get_next_month($month);
        $year++ if ($month == JANUARY && $omonth != $month); # shouldn't be necessary
    }
    elsif($date > 29 && $month == FEBRUARY)
    {
        $date = 1;
        $month = MARCH;
    }
    elsif($date > 28 && $month == FEBRUARY && !is_leap_year($year))
    {
        $date = 1;
        $month = MARCH;
    }

    return ($year, $month, $date, $day);
}

sub get_next_day
{
    my $day = shift;
    $day = $day + 1 > SATURDAY ? SUNDAY : $day + 1;
    return $day;
}

sub get_next_month
{
    my $month = shift;
    $month = $month + 1 > DECEMBER ? JANUARY : $month + 1;
    return $month;
}

sub get_date_string
{
    my ($year, $month, $date, $day) = @_;
    my $DAY_TO_STRING = [ 'DAY0', 'Sun.', 'Mon.', 'Tue.', 'Wed.', 'Thu.', 'Fri.', 'Sat.' ];
    my $MONTH_TO_STRING = [ 'MONTH0', 'Jan.', 'Feb.', 'Mar.', 'Apr.', 'May', 'June', 'July', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.' ];
    return sprintf(
        "%s\t%s\t%02d, %d",
        $DAY_TO_STRING->[$day],
        $MONTH_TO_STRING->[$month],
        $date,
        $year
    );
}

1;

