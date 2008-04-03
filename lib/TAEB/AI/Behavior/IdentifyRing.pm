#!/usr/bin/env perl
package TAEB::AI::Behavior::IdentifyRing;
use TAEB::OO;
extends 'TAEB::AI::Behavior';

sub prepare {
    my $self = shift;

    return 0 if TAEB->is_blind;

    my @items = grep { $self->pickup($_) } TAEB->inventory->items;
    return 0 unless @items;

    my $level = TAEB->nearest_level(sub { shift->has_type('sink') })
        or return 0;

    # are we standing on a sink? if so, drop!
    if (TAEB->current_tile->type eq 'sink') {
        $self->currently("Dropping the ring in the sink");
        $self->do(drop => items => \@items);
        return 100;
    }

    # find a sink
    my $path = TAEB::World::Path->first_match(
        sub { shift->type eq 'sink' },
        on_level => $level,
    );

    $self->if_path($path => "Heading towards a sink");
}

# collect unknown rings
sub pickup {
    my $self = shift;
    my $item = shift;

    # we only care about unidentified stuff and rings
    return 0 unless $item->match(identity => undef, class => 'ring');

    # We don't care about rings on sink tiles.
    return 0 if TAEB->current_tile->type eq 'sink';

    return 1;
}

sub drop {
    my $self = shift;
    my $item = shift;

    return unless $item->match(class => 'ring', identity => undef);

    return if TAEB->current_tile->type ne 'sink'
           || TAEB->is_blind;

    TAEB->debug("Yes, I want to drop $item because I want to find out what it is.");
    return 1;
}

sub urgencies {
    return {
        100 => "sink-identifying a ring",
        50 => "path to sink",
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

