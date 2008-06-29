package Graphics::Color::YIQ;
use Moose;

use Graphics::Color;

has 'luminance' => ( is => 'rw', isa => 'Num', default => 1 );
has 'in_phase' => ( is => 'rw', isa => 'Num', default => 1 );
has 'quadrature' => ( is => 'rw', isa => 'Num', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

sub as_string {
    my ($self) = @_;

    return sprintf('%s,%s,%s',
        $self->luminance, $self->in_phase, $self->quadrature
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->luminance, $self->in_phase, $self->quadrature);
}

1;
__END__

=head1 NAME

Graphics::Color::YIQ

=head1 DESCRIPTION

Graphics::Color::YIQ represents a Color in an YIQ color space.

=head1 DISCLAIMER

I couldn't find clear information on the bounds of each value, so at the
moment there are only 

=head1 SYNOPSIS

    use Graphics::Color::YIQ;

    my $color = Graphics::Color::YIQ->new({
        luminance   => 0.5,
        in_phase    => .5
        quadrature  => .25,
    });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Creates a new Graphics::Color::YIQ.

=back

=head2 Class Methods

=over 4

=item luminance

Set/Get the luminance component of this Color.

=item in_phase

Set/Get the in_phase component of this Color.

=item quadrature

Set/Get the quadrature component of this Color.

=item name

Get the name of this color.  Only valid if the color was created by name.

=item as_string

Get a string version of this Color in the form of
LUMINANCE,IN-PHASE,QUADRATURE

=item as_array

Get the YIQ values as an array

=back

=head1 AUTHOR

Cory Watson, C<< <cory.watson at iinteractive.com> >>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/YIQ>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.