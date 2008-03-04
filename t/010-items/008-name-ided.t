
#!perl -T
use strict;
use warnings;
use Test::More;
use List::Util 'sum';
use TAEB;

my @tests = (
    ["x - 100 gold pieces",
     {appearance => "gold piece", identity => "gold piece"}],
    ["a - a +1 long sword (weapon in hand)",
     {appearance => "long sword", identity => "long sword"}],
    ["b - a blessed +0 dagger",
     {appearance => "dagger", identity => "dagger"}],
    ["h - 8 +0 darts",
     {appearance => "dart", identity => "dart"}],
    ["s - a poisoned +0 arrow",
     {appearance => "arrow", identity => "arrow"}],
    ["p - a +0 boomerang",
     {appearance => "boomerang", identity => "boomerang"}],
    ["S - the +0 Cleaver",
     {appearance => "double-headed axe", identity => "Cleaver"}],
    ["c - an uncursed +3 small shield (being worn)",
     {appearance => "small shield", identity => "small shield"}],
    ["o - an uncursed +0 banded mail",
     {appearance => "banded mail", identity => "banded mail"}],
    ["q - an uncursed +0 crystal plate mail",
     {appearance => "crystal plate mail", identity => "crystal plate mail"}],
    ["t - a set of gray dragon scales",
     {appearance => "gray dragon scales", identity => "gray dragon scales"}],
    ["d - 2 uncursed food rations",
     {appearance => "food ration", identity => "food ration"}],
    ["j - a cursed tin of lichen",
     {appearance => "tin", identity => "tin of lichen"}],
    ["K - an uncursed tin of newt meat",
     {appearance => "tin", identity => "tin of newt meat"}],
    ["r - an uncursed partly eaten tripe ration",
     {appearance => "tripe ration", identity => "tripe ration"}],
    ["P - a blessed lichen corpse",
     {appearance => "lichen corpse", identity => "lichen corpse"}],
    ["R - an uncursed guardian naga egg",
     {appearance => "egg", identity => "guardian naga egg"}],
    ["w - an uncursed empty tin",
     {appearance => "tin", identity => "empty tin"}],
    ["T - the uncursed Book of the Dead",
     {appearance => "papyrus spellbook", identity => "Book of the Dead"}],
    ["C - an uncursed potion of water",
     {appearance => "clear potion", identity => "potion of water"}],
    ["U - the Amulet of Yendor",
     {appearance => "Amulet of Yendor", identity => "Amulet of Yendor"}],
    ["e - a +0 pick-axe",
     {appearance => "pick-axe", identity => "pick-axe"}],
    ["f - a +0 grappling hook",
     {appearance => "iron hook", identity => "grappling hook"}],
    ["t - an uncursed large box",
     {appearance => "large box", identity => "large box"}],
    ["W - a blessed magic lamp (lit)",
     {appearance => "lamp", identity => "magic lamp"}],
    ["m - the Master Key of Thievery",
     {appearance => "key", identity => "Master Key of Thievery"}],
    ["G - a cursed partly used wax candle (lit)",
     {appearance => "candle", identity => "wax candle"}],
    ["u - a figurine of a lichen",
     {appearance => "figurine of a lichen",
      identity => "figurine of a lichen"}],
    ["u - 53 rocks",
     {appearance => "rock", identity => "rock"}],
    ["n - the Heart of Ahriman",
     {appearance => "gray stone", identity => "Heart of Ahriman"}],
    ["v - a statue of a lichen",
     {appearance => "statue of a lichen", identity => "statue of a lichen"}],
);
plan tests => sum map { scalar keys %{ $_->[1] } } @tests;

for my $test (@tests) {
    my ($appearance, $expected) = @$test;
    my $item = TAEB::World::Item->new_item($appearance);
    while (my ($attr, $attr_expected) = each %$expected) {
        if (defined $item) {
            is($item->$attr, $attr_expected, "parsed $attr of $appearance");
        }
        else {
            fail("parsed $attr of $appearance");
            diag("$appearance produced an undef item object");
        }
    }
}
