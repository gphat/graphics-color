package Graphics::Color::RGB;
use Moose;

extends qw(Graphics::Color);

use Color::Library;
use Graphics::Color::HSL;
use Graphics::Color::HSV;

has 'red' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'green' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'blue' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'alpha' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('r' => __PACKAGE__->can('red'));
__PACKAGE__->meta->alias_method('g' => __PACKAGE__->can('green'));
__PACKAGE__->meta->alias_method('b' => __PACKAGE__->can('blue'));
__PACKAGE__->meta->alias_method('a' => __PACKAGE__->can('alpha'));

sub as_string {
    my ($self) = @_;

    return sprintf('%0.2f,%0.2f,%0.2f,%0.2f',
        $self->red, $self->green,
        $self->blue, $self->alpha
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
        $self->red * 255, $self->green * 255, $self->blue * 255
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

    return ($self->red, $self->green, $self->blue);
}

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->red, $self->green, $self->blue, $self->alpha);
}

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->red == $other->red) {
        return 0;
    }
    unless($self->green == $other->green) {
        return 0;
    }
    unless($self->blue == $other->blue) {
        return 0;
    }
    unless($self->alpha == $other->alpha) {
        return 0;
    }

    return 1;
}

sub from_color_library {
	my ($self, $id) = @_;

	my $color;
	if(ref($id)) {
		$color = $id;
	} else {
		$color = Color::Library->color($id);
		unless(defined($color)) {
			die("Couldn't find color for '$id'!");
		}
	}

	my ($r, $g, $b) = $color->rgb;
	return Graphics::Color::RGB->new(
		red => $r / 255,
		green => $g / 255,
		blue => $b / 255
	);
}

sub to_hsl {
	my ($self) = @_;

	my $max = $self->red;
	my $maxc = 'r';
	my $min = $self->red;

	if($self->green > $max) {
		$max = $self->green;
		$maxc = 'g';
	}
	if($self->blue > $max) {
		$max = $self->blue;
		$maxc = 'b';
	}

	if($self->green < $min) {
		$min = $self->green;
	}
	if($self->blue < $min) {
		$min = $self->blue;
	}

	my ($h, $s, $l);

	if($max == $min) {
		$h = 0;
	} elsif($maxc eq 'r') {
		$h = 60 * (($self->green - $self->blue) / ($max - $min)) % 360;
	} elsif($maxc eq 'g') {
		$h = (60 * (($self->blue - $self->red) / ($max - $min)) + 120);
	} elsif($maxc eq 'b') {
		$h = (60 * (($self->red - $self->green) / ($max - $min)) + 240);
	}

	$l = ($max + $min) / 2;

	if($max == $min) {
		$s = 0;
	} elsif($l <= .5) {
		$s = ($max - $min) / ($max + $min);
	} else {
		$s = ($max - $min) / (2 - ($max + $min));
	}

	return Graphics::Color::HSL->new(
		hue => $h, saturation => $s, lightness => $l, alpha => $self->alpha
	);
}

sub to_hsv {
	my ($self) = @_;

	my $max = $self->red;
	my $maxc = 'r';
	my $min = $self->red;

	if($self->green > $max) {
		$max = $self->green;
		$maxc = 'g';
	}
	if($self->blue > $max) {
		$max = $self->blue;
		$maxc = 'b';
	}

	if($self->green < $min) {
		$min = $self->green;
	}
	if($self->blue < $min) {
		$min = $self->blue;
	}

	my ($h, $s, $v);

	if($max == $min) {
		$h = 0;
	} elsif($maxc eq 'r') {
		$h = 60 * (($self->green - $self->blue) / ($max - $min)) % 360;
	} elsif($maxc eq 'g') {
		$h = (60 * (($self->blue - $self->red) / ($max - $min)) + 120);
	} elsif($maxc eq 'b') {
		$h = (60 * (($self->red - $self->green) / ($max - $min)) + 240);
	}

	$v = $max;
	if($max == 0) {
		$s = 0;
	} else {
		$s = 1 - ($min / $max);
	}

	return Graphics::Color::HSV->new(
		hue => $h, saturation => $s, value => $v, alpha => $self->alpha
	);
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::RGB - RGB color model

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

=item I<equal_to>

Compares this color to the provided one.  Returns 1 if true, else 0;

=item I<not_equal_to>

The opposite of equal_to.

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

=item I<from_color_library (color-id)>

Attempts to retrieve the specified color-id using L<Color::Library>.  The
result is then converted into a Graphics::Color::RGB object.

=item I<to_hsl>

Creates this RGB color in HSL space.  Returns a L<Graphics::Color::HSL> object.

=item I<to_hsv>

Creates this RGB color in HSV space.  Returns a L<Graphics::Color::HSV> object.

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<<a href="http://en.wikipedia.org/wiki/RGB_color_space">Wikipedia</a>>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
