#!/usr/bin/env perl
package TAEB::World::Item::Armor;
use TAEB::OO 'install_spoilers';
extends 'TAEB::World::Item';
with 'TAEB::World::Item::Role::Enchantable';
with 'TAEB::World::Item::Role::Erodable';
with 'TAEB::World::Item::Role::Wearable';

has '+class' => (
    default => 'armor',
);

install_spoilers(qw/ac mc/);

make_immutable;
no Moose;

1;

