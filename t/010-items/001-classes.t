#!perl -T
use strict;
use warnings;
use Test::More;
use List::Util 'sum';
use TAEB;

my @tests = (
    ["x - 100 gold pieces",                             {class => "gold"}     ],
    ["a - a +1 long sword (weapon in hand)",            {class => "weapon"}   ],
    ["b - a blessed +0 dagger",                         {class => "weapon"}   ],
    ["h - 8 +0 darts",                                  {class => "weapon"}   ],
    ["s - a poisoned +0 arrow",                         {class => "weapon"}   ],
    ["p - a +0 boomerang",                              {class => "weapon"}   ],
    ["S - the +0 Cleaver",                              {class => "weapon"}   ],
    ["c - an uncursed +3 small shield (being worn)",    {class => "armor"}    ],
    ["o - an uncursed +0 banded mail",                  {class => "armor"}    ],
    ["q - an uncursed +0 crystal plate mail",           {class => "armor"}    ],
    ["h - the uncursed +0 Mitre of Holiness",           {class => "armor"}    ],
    ["t - a set of gray dragon scales",                 {class => "armor"}    ],
    ["d - 2 uncursed food rations",                     {class => "food"}     ],
    ["j - a cursed tin of lichen",                      {class => "food"}     ],
    ["K - an uncursed tin of newt meat",                {class => "food"}     ],
    ["r - an uncursed partly eaten tripe ration",       {class => "food"}     ],
    ["P - a blessed lichen corpse",                     {class => "food"}     ],
    ["R - an uncursed guardian naga egg",               {class => "food"}     ],
    ["w - an uncursed empty tin",                       {class => "food"}     ],
    ["N - an uncursed blank scroll",                    {class => "scroll"}   ],
    ["k - an uncursed spellbook of blank paper",        {class => "spellbook"}],
    ["T - the uncursed Book of the Dead",               {class => "spellbook"}],
    ["C - an uncursed potion of water",                 {class => "potion"}   ],
    ["k - the Eye of the Aethiopica",                   {class => "amulet"}   ],
    ["U - the Amulet of Yendor",                        {class => "amulet"}   ],
    ["e - a +0 pick-axe",                               {class => "tool"}     ],
    ["f - a +0 grappling hook",                         {class => "tool"}     ],
    ["t - an uncursed large box",                       {class => "tool"}     ],
    ["m - the Master Key of Thievery",                  {class => "tool"}     ],
    ["u - a figurine of a lichen",                      {class => "tool"}     ],
    ["u - 53 rocks",                                    {class => "gem"}      ],
    ["n - the Heart of Ahriman",                        {class => "gem"}      ],
    ["v - a statue of a lichen",                        {class => "statue"}   ],
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
