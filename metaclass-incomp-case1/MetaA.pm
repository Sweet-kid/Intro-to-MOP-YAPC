package MetaA;
use strict;
use warnings;

sub c_bar {
    print "in c_bar\n";
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
    } # end while loop

    @{"${class}::ISA"} = @{$options{ superclasses }}
    if( $options{ superclasses } && @{$options{ superclasses }} );
    use strict;

    set_metaclass( $class, \%options );
}

1;
