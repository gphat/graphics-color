package Graphics::Color::HSL;
use Moose;
use MooseX::Aliases;

extends qw(Graphics::Color);

# ABSTRACT: HSL color space

with 'Graphics::Color::Equal';

use Graphics::Color::Types qw(Number360OrLess NumberOneOrLess);

=head1 DESCRIPTION

Graphics::Color::HSL represents a Color in an RGB color space.  HSL stands for
B<Hue> B<Saturation> and B<Lightness>.

=head1 SYNOPSIS

    use Graphics::Color::HSL;

    my $color = Graphics::Color::HSL->new({
        hue         => 120,
        saturation  => .5,
        lightness   => .25,
    });

=attr hue

=attr h

Set/Get the hue component of this Color.

=cut

has 'hue' => (
    is => 'rw',
    isa => Number360OrLess,
    default => 1,
    alias => 'h'
);

=attr saturation

=attr s

Set/Get the saturation component of this Color.

=cut

has 'saturation' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 's'
);

=attr lightness

=attr l

Set/Get the lightness component of this Color.

=cut

has 'lightness' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'l'
);

=attr alpha

Set/Get the alpha component of this Color.

=cut

has 'alpha' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'a'
);

=attr name

Get the name of this color.  Only valid if the color was created by name.

=cut

has 'name' => ( is => 'rw', isa => 'Str' );

=method as_string

Get a string version of this Color in the form of:
HUE,SATURATION,LIGHTNESS,ALPHA

=cut

sub as_string {
    my ($self) = @_;

    return sprintf('%d,%0.2f,%0.2f,%0.2f',
        $self->hue, $self->saturation, $self->lightness, $self->alpha
    );
}

=method as_percent_string

Return a percent formatted value for this color.  This format is suitable for
CSS HSL values.

=cut

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d, %d%%, %d%%, %0.2f",
        $self->hue, $self->saturation * 100, $self->lightness * 100,
        $self->alpha
    );
}

=method as_array

Get the HSL values as an array

=cut

sub as_array {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness);
}

=method as_array_with_alpha

Get the HSLA values as an array

=cut

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->lightness, $self->alpha);
}

=method equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=method not_equal_to

The opposite of equal_to.

=cut

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

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