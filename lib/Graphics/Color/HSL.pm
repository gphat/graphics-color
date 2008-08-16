package Graphics::Color::HSL;
use Moose;

extends qw(Graphics::Color);

with 'Graphics::Color::Equal';

has 'hue' => ( is => 'rw', isa => 'Graphics::Color::Number360OrLess', default => 1 );
has 'saturation' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'lightness' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'alpha' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('h' => __PACKAGE__->can('hue'));
__PACKAGE__->meta->alias_method('s' => __PACKAGE__->can('saturation'));
__PACKAGE__->meta->alias_method('l' => __PACKAGE__->can('lightness'));

sub as_string {
    my ($self) = @_;

    return sprintf('%d,%0.2f,%0.2f,%0.2f',
        $self->hue, $self->saturation, $self->lightness, $self->alpha
    );
}

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d, %d%%, %d%%, %0.2f",
        $self->hue, $self->saturation * 100, $self->lightness * 100,
        $self->alpha
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness);
}

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness, $self->alpha);
}

sub equal_to {
    my ($self, $other) = @_;

    unless($self->hue == $other->hue) {
        return 0;
    }
    unless($self->saturation == $other->saturation) {
        return 0;
    }
    unless($self->lightness == $other->lightness) {
        return 0;
    }
    unless($self->alpha == $other->alpha) {
        return 0;
    }

    return 1;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::HSL - HSL color space

=head1 DESCRIPTION

Graphics::Color::HSL represents a Color in an RGB color space.  HSL stands for
B<Hue> B<Saturation> and B<Lightness>.

=head1 SYNOPSIS

    use Graphics::Color::HSL;

    my $color = Graphics::Color::HSL->new({
        hue         => 120,
        saturation  => .5
        lightness   => .25,
    });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Creates a new Graphics::Color::HSL.

=back

=head2 Instance Methods

=over 4

=item I<equal_to>

Compares this color to the provided one.  Returns 1 if true, else 0;

=item I<not_equal_to>

The opposite of equal_to.

=item I<hue>

=item I<h>

Set/Get the hue component of this Color.

=item I<saturation>

=item I<s>

Set/Get the saturation component of this Color.

=item I<lightness>

=item I<l>

Set/Get the lightness component of this Color.

=item I<alpha>

Set/Get the alpha component of this Color.

=item I<name>

Get the name of this color.  Only valid if the color was created by name.

=item I<as_string>

Get a string version of this Color in the form of
HUE,SATURATION,LIGHTNESS,ALPHA

=item I<as_percent_string>

Return a percent formatted value for this color.  This format is suitable for
CSS HSL values.

=item I<as_array>

Get the HSL values as an array

=item I<as_array_with_alpha>

Get the HSLA values as an array

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/HSL_color_space>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
