package Graphics::Color::YIQ;
use Moose;

extends qw(Graphics::Color);

has 'luminance' => ( is => 'rw', isa => 'Num', default => 1 );
has 'in_phase' => ( is => 'rw', isa => 'Num', default => 1 );
has 'quadrature' => ( is => 'rw', isa => 'Num', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('y' => __PACKAGE__->can('luminance'));
__PACKAGE__->meta->alias_method('i' => __PACKAGE__->can('in_phase'));
__PACKAGE__->meta->alias_method('q' => __PACKAGE__->can('quadrature'));

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

__PACKAGE__->meta->make_immutable;

no Moose;
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

=item I<new>

Creates a new Graphics::Color::YIQ.

=back

=head2 Instance Methods

=over 4

=item I<luminance>

=item I<y>

Set/Get the luminance component of this Color.

=item I<in_phase>

=item I<i>

Set/Get the in_phase component of this Color.

=item I<quadrature>

=item I<q>

Set/Get the quadrature component of this Color.

=item I<name>

Get the name of this color.  Only valid if the color was created by name.

=item I<as_string>

Get a string version of this Color in the form of
LUMINANCE,IN-PHASE,QUADRATURE

=item I<as_array>

Get the YIQ values as an array

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/YIQ>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
