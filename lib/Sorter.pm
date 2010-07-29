package Sorter;
use Moose;

has 'values', (
    is  => 'rw',
    isa => 'ArrayRef',
    handles => {
        sort       => [ sort_in_place => sub { $_[0] <=> $_[1] } ],
        get_values => 'elements',
    },
    default => sub { [] },
    traits  => [ 'Array' ],
);

sub set_values { shift->values([ @_ ]) }

1;
