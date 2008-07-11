package Graphics::Color::RGB;
use Moose;

extends qw(Graphics::Color);

has 'red' => ( is => 'rw', isa => 'NumberOneOrLess', default => 1 );
has 'green' => ( is => 'rw', isa => 'NumberOneOrLess', default => 1 );
has 'blue' => ( is => 'rw', isa => 'NumberOneOrLess', default => 1 );
has 'alpha' => ( is => 'rw', isa => 'NumberOneOrLess', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('r' => __PACKAGE__->can('red'));
__PACKAGE__->meta->alias_method('g' => __PACKAGE__->can('green'));
__PACKAGE__->meta->alias_method('b' => __PACKAGE__->can('blue'));
__PACKAGE__->meta->alias_method('a' => __PACKAGE__->can('alpha'));

sub as_string {
    my ($self) = @_;

    return sprintf('%0.2f,%0.2f,%0.2f,%0.2f',
        $self->red(), $self->green(),
        $self->blue(), $self->alpha()
    );
}

sub as_integer_string {
    my ($self) = @_;

    return sprintf("%d, %d, %d, %0.2f",
        $self->red * 255, $self->green * 255, $self->blue * 255, $self->alpha
    );
}

sub as_hex_string {
    my ($self) = @_;

    return sprintf('#%x%x%x',
        $self->red() * 255, $self->green() * 255, $self->blue() * 255
    );
}

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d%%, %d%%, %d%%, %0.2f",
        $self->red * 100, $self->green * 100, $self->blue * 100, $self->alpha
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->red(), $self->green(), $self->blue());
}

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->red(), $self->green(), $self->blue(), $self->alpha());
}

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::RGB

=head1 DESCRIPTION

Graphics::Color::RGB represents a Color in the sRGB color space.  Individual
color channels are expressed as decimal values from 0 to 1.  Convenience
methods are supplied to convert to various string values.

=head1 SYNOPSIS

    use Graphics::Color::RGB;

    my $color = Graphics::Color::RGB->new({
        red     => 1,
        blue    => .31,
        green   => .25,
    });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Creates a new Graphics::Color::RGB.

=back

=head2 Instance Methods

=over 4

=item I<red>

=item I<r>

Set/Get the red component of this Color.  Aliased to a 'r' as well.

=item I<green>

=item I<g>

Set/Get the green component of this Color. Aliased to a 'g' as well.

=item I<blue>

=item I<b>

Set/Get the blue component of this Color. Aliased to a 'b' as well.

=item I<alpha>

=item I<a>

Set/Get the alpha component of this Color. Aliased to a 'a' as well.

=item I<name>

Get the name of this color.  Only valid if the color was created by name.

=item I<as_string>

Get a string version of this Color in the form of RED,GREEN,BLUE,ALPHA

=item I<as_hex_string>

Return a hex formatted value for this color.  The output ignores the alpha
channel because, per the W3C, there is no hexadecimal notiation for an RGBA
value.

=item I<as_integer_string>

Return an integer formatted value for this color.  This format is suitable for
CSS RGBA values.

=item I<as_percent_string>

Return a percent formatted value for this color.  This format is suitable for
CSS RGBA values.

=item I<as_array>

Get the RGB values as an array

=item I<as_array_with_alpha>

Get the RGBA values as an array

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/RGB_color_space>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
