package Matrix;

use strict;
use warnings;

sub new
{
    my ($class, $rows, $cols) = @_;

    # TODO: for now size is required
    die "ERROR: dimensions must be specified for new matrix." if !$rows;

    $cols = $rows if !$cols; # square matrix
    my @data;
    $#data = ($rows * $cols - 1);
    my $self = {
        _rows => $rows,
        _cols => $cols,
        _data => \@data,
        _contains_non_int => 0
    };

    bless $self, $class;
    return $self;
}

sub numRows
{
    my $self = shift;
    return $self->{_rows};
}

sub numCols
{
    my $self = shift;
    return $self->{_cols};
}

sub get
{
    my ($self, $row, $col) = @_;
    $row -= 1;
    $col -= 1;
    my $cols = $self->numCols;
    my $data = $self->{_data};
    return $data->[$row*$cols + $col];
}

sub set
{
    my ($self, $row, $col, $val) = @_;
    my $cols = $self->numCols;
    $row -= 1;
    $col -= 1;
    $self->{_contains_non_int} = 1 if($val != int($val));
    $self->{_data}->[$row*$cols + $col] = $val;
}

sub print
{
    my $self = shift;
    my $rows = $self->numRows();
    my $cols = $self->numCols();
    my $print_fmt = $self->{_contains_non_int} ? "%3.02d" : "%3d";

    for(my $k = 0; $k < $rows; $k++)
    {
        for(my $l = 0; $l < $cols; $l++)
        {
            my $val = $self->get($k+1, $l+1) || 0;
            printf($print_fmt, $val);
            print " ";
        }
        print "\n";
    }
}

# get diagonal starting at top left corner ending at bottom right
sub get_left_diagonal
{
    my $self = shift;
    my $rows = $self->numRows();
    my $cols = $self->numCols();
    my @diagonal = ();
    
    die "ERROR: invalid request for diagonal with a non square matrix" if($rows != $cols);

    for(my $k = 0; $k < $rows; $k++)
    {
        push(@diagonal, $self->get($k+1, $k+1));
    }

    return \@diagonal;
}

# get diagonal starting at bottom left corner ending at top right
sub get_right_diagonal
{
    my $self = shift;
    my $rows = $self->numRows();
    my $cols = $self->numCols();
    my @diagonal = ();
    
    die "ERROR: invalid request for diagonal with a non square matrix" if($rows != $cols);

    for(my $k = 0; $k < $rows; $k++)
    {
        push(@diagonal, $self->get($rows - $k, $k + 1));
    }

    return \@diagonal;
}

return 1;

