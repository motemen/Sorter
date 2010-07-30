package Sorter;
use Moose;

has 'values', (
    isa        => 'ArrayRef',
    default    => sub { [] },
    traits     => [ 'Array' ],
    writer     => 'set_values',
    reader     => 'get_values',
    handles    => { sort => [ sort_in_place => sub { $_[0] <=> $_[1] } ] },
    auto_deref => 1,
);

around set_values => sub {
    my ($orig, $self, @args) = @_;
    $self->$orig(\@args);
};

( meta __PACKAGE__ ) -> make_immutable;

no Moose;
