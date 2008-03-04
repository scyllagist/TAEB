#!perl -T
use strict;
use warnings;
use Test::More;
use List::Util 'sum';
use TAEB;

my @tests = (
    ["x - a samurai sword",
     {appearance => "samurai sword", identity => "katana"}],
    ["y - a crude dagger",
     {appearance => "crude dagger", identity => "orcish dagger"}],
    ["z - a broad pick",
     {appearance => "broad pick", identity => "dwarvish mattock"}],
    ["f - a double-headed axe named Cleaver",
     {appearance => "double-headed axe", identity => "Cleaver"}],
    ["A - a crude ring mail",
     {appearance => "crude ring mail", identity => "orcish ring mail"}],
    ["B - an apron",
     {appearance => "apron", identity => "alchemy smock"}],
    ["C - a faded pall",
     {appearance => "faded pall", identity => "elven cloak"}],
    ["s - a pair of riding gloves",
     {appearance => "riding gloves", identity => undef}],
    ["i - an egg",
     {appearance => "egg", identity => undef}],
    ["D - a tin",
     {appearance => "tin", identity => undef}],
    ["f - a scroll labeled PRATYAVAYAH",
     {appearance => "scroll labeled PRATYAVAYAH", identity => undef}],
    ["m - a scroll labeled JUYED AWK YACC",
     {appearance => "scroll labeled JUYED AWK YACC", identity => undef}],
    ["E - a scroll labeled FOOBIE BLETCH",
     {appearance => "scroll labeled FOOBIE BLETCH", identity => undef}],
    ["l - an orange spellbook",
     {appearance => "orange spellbook", identity => undef}],
    ["n - a light blue spellbook",
     {appearance => "light blue spellbook", identity => undef}],
    ["u - a magenta spellbook",
     {appearance => "magenta spellbook", identity => undef}],
    ["g - a papyrus spellbook",
     {appearance => "papyrus spellbook", identity => "Book of the Dead"}],
    ["N - a murky potion",
     {appearance => "murky potion", identity => undef}],
    ["O - a sky blue potion",
     {appearance => "sky blue potion", identity => undef}],
    ["P - a brown potion",
     {appearance => "brown potion", identity => undef}],
    ["Q - a clear potion",
     {appearance => "clear potion", identity => "potion of water"}],
    ["h - a hexagonal amulet",
     {appearance => "hexagonal amulet", identity => undef}],
    ["G - a triangular amulet",
     {appearance => "triangular amulet", identity => undef}],
    ["H - a pyramidal amulet",
     {appearance => "pyramidal amulet", identity => undef}],
    ["q - a gold ring",
     {appearance => "gold ring", identity => undef}],
    ["t - a granite ring",
     {appearance => "granite ring", identity => undef}],
    ["v - an opal ring",
     {appearance => "opal ring", identity => undef}],
    ["K - a runed wand",
     {appearance => "runed wand", identity => undef}],
    ["L - a brass wand",
     {appearance => "brass wand", identity => undef}],
    ["M - an oak wand",
     {appearance => "oak wand", identity => undef}],
    ["g - 2 yellow gems",
     {appearance => "yellow gem", identity => undef}],
    ["I - a green gem",
     {appearance => "green gem", identity => undef}],
    ["Q - a gray stone",
     {appearance => "gray stone", identity => undef}],
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
