package t::sort;
use strict;
use warnings;
use base 'Test::Class';
use Test::More;

sub load : Test(startup => 1) {
    use_ok 'Sorter';
}

sub values : Test(5) {
    my $sorter = new_ok 'Sorter' or return;
    is_deeply [$sorter->get_values], [];

    $sorter->set_values;
    is_deeply [$sorter->get_values], [];

    $sorter->set_values(1);
    is_deeply [$sorter->get_values], [1];

    $sorter->set_values(1,2,3,4,5);
    is_deeply [$sorter->get_values], [1,2,3,4,5];
}

sub sort : Test(12) {
    my $sorter = new_ok 'Sorter' or return;
    $sorter->sort;
    is_deeply [$sorter->get_values], [];

    $sorter->set_values(1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1];

    $sorter->set_values(5,4,3,2,1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,5];

    $sorter->set_values(-1,-2,-3,-4,-5);
    $sorter->sort;
    is_deeply [$sorter->get_values], [-5,-4,-3,-2,-1];

    $sorter->set_values(1,2,3,4,5);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,5];

    $sorter->set_values(5,5,4,4,4,3,2,1);
    $sorter->sort;
    is_deeply [$sorter->get_values], [1,2,3,4,4,4,5,5];

    for (0..4) {
        my @random_values = ();
        push(@random_values, int(rand() * 100) - 50)  for 0..99;
        $sorter->set_values(@random_values);
        $sorter->sort;
        is_deeply [$sorter->get_values], [sort { $a <=> $b } @random_values];
    }
}

__PACKAGE__->runtests;

1;
