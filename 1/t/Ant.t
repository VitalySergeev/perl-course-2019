#!/usr/bin/env perl

use feature 'postderef';
use Test::More tests => 3;

use FindBin qw( $Bin );

use lib "$Bin/../";

use Ant qw( travel step_forward turn TURN_LEFT TURN_RIGHT );

subtest 'turn()' => sub {
    plan tests => 8;

    my @tests = (
        [
            [ 0,  1 ],
            [ -1, 0 ],
        ],
        [
            [ -1,  0 ],
            [ 0, -1  ],
        ],
        [
            [ 0, -1  ],
            [ 1,  0 ],
        ],
        [
            [ 1,  0 ],
            [ 0, 1  ],
        ],
    );

    foreach my $test ( @tests ) {
        my @res = turn( @{ $test->[0] }, TURN_LEFT );
        is_deeply( \@res, $test->[1] );
    }

    foreach my $test ( @tests ) {
        my @res = turn( @{ $test->[1] }, TURN_RIGHT );
        is_deeply( \@res, $test->[0] );
    }

};

subtest 'step_forward()' => sub {
    plan tests => 8;

    my @tests = (
        [
            [ 3, 0, 4, 1, 0 ],
            [ 0, 0 ],
        ],
        [
            [ 0, 0, 4, -1, 0 ],
            [ 3, 0 ],
        ],
        [
            [ 2, 0, 4, 1, 0 ],
            [ 3, 0 ],
        ],
        [
            [ 1, 0, 4, -1, 0 ],
            [ 0, 0 ],
        ],
        [
            [ 0, 3, 4, 0, 1 ],
            [ 0, 0 ],
        ],
        [
            [ 0, 0, 4, 0, -1 ],
            [ 0, 3 ],
        ],
        [
            [ 0, 2, 4, 0, 1 ],
            [ 0, 3 ],
        ],
        [
            [ 0, 1, 4, 0, -1 ],
            [ 0, 0 ],
        ],
    );

    foreach my $test ( @tests ) {
        my @res = step_forward( @{ $test->[0] } );
        is_deeply( \@res, $test->[1] );
    }
};

subtest 'travel()' => sub {
    plan tests => 3;

    my @tests = (
        {
            # ^ x. < #x v ## < ## v x# > .x
            # 0 .. 1 .. 2 .x 3 x# 4 ## 5 ##
            data => [
                [                   # field
                    [  1, -1 ],
                    [ -1, -1 ],
                ],
                0, 0,               # x,y
                5,                  # steps
                0, 1                # dir
            ],
            result => [
                [  1,  1 ],
                [  1,  1 ],
            ]
        },
        {
            # ^ x# > .x v .. < .. ^ x. < #.
            # 0 ## 1 ## 2 #x 3 x. 4 .. 5 x.
            data => [
                [                   # field
                    [ 1, 1 ],
                    [ 1, 1 ],
                ],
                0, 0,               # x,y
                5,                  # steps
                0, 1                # dir
            ],
            result => [
                [  1, -1 ],
                [ -1, -1 ],
            ]
        },
        {
            # v x# < #x v #. < #. ^ x. > .x
            # 0 #. 1 #. 2 #x 3 x# 4 .# 5 .#
            data => [
                [                   # field
                    [ -1,  1 ],
                    [  1, -1 ],
                ],
                0, 0,               # x,y
                5,                  # steps
                0, -1               # dir
            ],
            result => [
                [ -1, -1 ],
                [ -1,  1 ],
            ]
        },
    );

    foreach my $test ( @tests ) {
        travel( @{ $test->{data} } );
        is_deeply( $test->{data}->[0], $test->{result} );
    }
};
