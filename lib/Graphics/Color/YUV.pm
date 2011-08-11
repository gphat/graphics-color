package Graphics::Color::YUV;
use Moose;
use MooseX::Aliases;

extends qw(Graphics::Color);

# ABSTRACT: YUV color space

use Graphics::Color::Types qw(NumberOneOrLess);

=head1 DESCRIPTION

Graphics::Color::YUV represents a Color in an Y'UV color space.

=head1 SYNOPSIS

    use Graphics::Color::YUV;

    my $color = Graphics::Color::YUV->new({
        luma            => .5,
        blue_luminance  => .5
        red_luminance   => .25,
    });

=attr luma

=attr y

Set/Get the luma (Y') component of this Color.  Aliased to y.

=cut

has 'luma' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 0,
    alias => 'y'
);

=attr blue_luminance

=attr u

Set/Get the blue_luminance component of this Color. Aliased to u.

=cut

has 'blue_luminance' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 0,
    alias => 'u'
);

=attr red_luminance

=attr v

Set/Get the red_luminance component of this Color. Aliased to v.

=cut

has 'red_luminance' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 0,
    alias => 'v'
);

=method name

Get the name of this color.  Only valid if the color was created by name.

=cut

has 'name' => ( is => 'rw', isa => 'Str' );

=method as_string

Get a string version of this Color in the form of:
LUMA,BLUE_LUMINENCE,RED_LUMINANCE

=cut

sub as_string {
    my ($self) = @_;

    return sprintf('%s,%s,%s',
        $self->luma, $self->blue_luminance, $self->red_luminance
    );
}

=method as_array

Get the YUV values as an array

=cut

sub as_array {
    my ($self) = @_;

    return ($self->luma, $self->blue_luminance, $self->red_luminance);
}

=method equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=cut

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->luma == $other->luma) {
        return 0;
    }
    unless($self->blue_luminance == $other->blue_luminance) {
        return 0;
    }
    unless($self->red_luminance == $other->red_luminance) {
        return 0;
    }

    return 1;
}

=method not_equal_to

The opposite of equal_to.

=cut

# TODO RGB Conversion
# OLD STYLE : Y' = 0.299R + 0.587G + 0.114B
# NEW STYLE: Y' = 0.2125R + 0.7154G + 0.0721B
# U = B - Y'
# V = R - Y'
#
# http://www.fourcc.org/fccyvrgb.php

__PACKAGE__->meta->make_immutable;

no Moose;
1;