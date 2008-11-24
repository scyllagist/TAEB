#!/usr/bin/env perl
package TAEB::Action::Apply;
use TAEB::OO;
extends 'TAEB::Action';
with 'TAEB::Action::Role::Direction';
with 'TAEB::Action::Role::Item';

use constant command => "a";

has +item => (
    required => 1,
);

sub respond_apply_what { shift->item->slot }

sub msg_nothing_happens {
    my $self = shift;
    my $item = $self->item;

    # nothing happens is good! we know we don't have these status effects
    if ($item->match(identity => 'unicorn horn')) {
        for (qw/blindness confusion stunning hallucination/) {
            TAEB->enqueue_message(status_change => $_ => 0);
        }
    }
}

sub msg_status_change {
    my $self = shift;
    my $status = shift;
    my $have = shift;

    # we lost the effect, so we don't care
    return if !$have;

    my $item = $self->item;
    if ($item->identity eq 'unicorn horn') {
        TAEB->info("We seem to have gained the '$status' effect and we rubbed $item this turn. Marking it as cursed.");
        $item->buc("cursed");
    }
}

sub msg_negative_stethoscope {
    my $self = shift;

    $self->target_tile->inc_searched(50); # should be infinity
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

