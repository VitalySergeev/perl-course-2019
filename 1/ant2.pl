#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw( $Bin );
use lib "$Bin/";

use Ant qw( travel );

use constant {
    FIELD_SIZE  => 70,
    START_X     => 35,
    START_Y     => 35,
    START_DIR_X => 0,
    START_DIR_Y => 1,
    STEPS       => 9000,
};

my @field;

push @field, [ (-1) x ( FIELD_SIZE ) ] for 1 .. FIELD_SIZE;

travel( \@field, START_X, START_Y, STEPS, START_DIR_X, START_DIR_Y );

print join '', ( map { $_ == 1 ? '#' : '.' } @$_ ), "\n" foreach @field;
