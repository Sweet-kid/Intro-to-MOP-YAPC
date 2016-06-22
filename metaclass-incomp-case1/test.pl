use strict;
use warnings;

use MetaA;
use MetaB;

use Data::Dumper;

MetaA->create_class(
    package => 'A',
    methods => {
        new => sub {
            my ($self)     = shift;
            my $attributes = { @_ };
            return bless $attributes, $self;
        },
        i_foo => sub {
            my ($self) = shift;
            my $meta   = $self->meta;
            # MetaB (i.e. the metaclass of class B
            # doesn't have a method called c_bar,
            # so you will get this error:
            # Can't locate object method "c_bar" via package "MetaB" at test.pl line 20.
            $meta->c_bar;
        },
    },
);

my $a = A->new();
A->i_foo;

MetaB->create_class(
    package => 'B',
    methods => {
        new => sub {
            my ($self)     = shift;
            my $attributes = { @_ };
            return bless $attributes, $self;
        },
    },
    superclasses => [ 'A' ],
);

my $b = B->new();
B->i_foo;
