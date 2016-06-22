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
        i_bar => sub {
            print "in i_bar\n";
        },
    },
);

MetaA->c_foo( 'A' );

MetaB->create_class(
    package => 'B',
    methods => {
        new => sub {
            my ($self)     = shift;
            my $attributes = { @_ };
            return bless $attributes, $self;
        },
    },
);

MetaB->c_foo( 'B' );
