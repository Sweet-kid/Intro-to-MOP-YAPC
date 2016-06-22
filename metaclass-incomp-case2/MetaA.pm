package MetaA;
use strict;
use warnings;

# When you will invoke this method from MetaA, with
# argument 'A', then everything will work fine.
# But when you will invoke it from MetaB, with 'B'
# as an argument, then it will fail with this error:

# Can't locate object method "i_bar" via package "B" at MetaA.pm line 7.

# Infact, it will fail for every argument which doesn't
# have an i_bar method
sub c_foo {
    my ( $self, $child ) = @_;
    $child->i_bar;
}

my %meta_to_class;

sub get_meta {
    my $class = shift;
    MetaA->get_metaclass( $class );
};

sub get_metaclass {
    my $class = shift;
    return bless $meta_to_class{ $_[ 0 ] }, $class;
}

sub set_metaclass {
    $meta_to_class{ $_[ 0 ] } = $_[ 1 ];
}

sub create_class {
    my ($self, %options) = @_;
    my $class   = $options{ package };
      $options{ methods }->{ meta } = \&get_meta;

    my $methods = $options{ methods };
    no strict 'refs';
    while( my ($method, $body) = each( %$methods ) ) {
        *{ "${class}::$method" } = $body;
    }

    if( $options{ superclasses } && @{$options{ superclasses }} ) {
        @{"${class}::ISA"} = @{$options{ superclasses }};
    }
    use strict;

    set_metaclass( $class, \%options );
}

1;
