package Graphics::Color::HSV;
use Moose;

extends qw(Graphics::Color);

with 'Graphics::Color::Equal';

use Graphics::Color::RGB;

has 'hue' => ( is => 'rw', isa => 'Graphics::Color::Number360OrLess', default => 1 );
has 'saturation' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'value' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'alpha' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('h' => __PACKAGE__->can('hue'));
__PACKAGE__->meta->alias_method('s' => __PACKAGE__->can('saturation'));
__PACKAGE__->meta->alias_method('v' => __PACKAGE__->can('value'));

sub as_string {
    my ($self) = @_;

    return sprintf('%d,%0.2f,%0.2f,%0.2f',
        $self->hue, $self->saturation, $self->value, $self->alpha
    );
}

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d, %d%%, %d%%, %0.2f",
        $self->hue, $self->saturation * 100, $self->value * 100,
        $self->alpha
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->value);
}

sub as_array_with_alpha {
    my ($self) = @_;

    return ($self->hue, $self->saturation, $self->value, $self->alpha);
}

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->hue == $other->hue) {
        return 0;
    }
    unless($self->saturation == $other->saturation) {
        return 0;
    }
    unless($self->value == $other->value) {
        return 0;
    }
    unless($self->alpha == $other->alpha) {
        return 0;
    }

    return 1;
}

sub to_rgb {
	my ($self) = @_;

	my ($h, $s, $v) = ($self->h, $self->s, $self->v);

	my ($red, $green, $blue);

	if($v == 0) {
		($red, $green, $blue) = (0, 0, 0);
	} elsif($s == 0) {
		($red, $green, $blue) = ($v, $v, $v);
	} else {
		my $hf = $h / 60;
		my $i = int($hf);
		my $f = $hf - $i;
		my $pv = $v * (1 - $s);
		my $qv = $v * (1 - $s * $f);
		my $tv = $v * (1 - $s * (1 - $f));

		if($i == 0) {
			$red = $v;
			$green = $tv;
			$blue = $pv;
		} elsif($i == 1) {
			$red = $qv;
			$green = $v;
			$blue = $pv;
		} elsif($i == 2) {
			$red = $pv;
			$green = $v;
			$blue = $tv;
		} elsif($i == 3) {
			$red = $pv;
			$green = $qv;
			$blue = $v;
		} elsif($i == 4) {
			$red = $tv;
			$green = $pv;
			$blue = $v;
		} elsif($i == 5) {
			$red = $v;
			$green = $pv;
			$blue = $qv;
		} elsif($i == 6) {
			$red = $v;
			$blue = $tv;
			$green = $pv;
		} elsif($i == -1) {
			$red = $v;
			$green = $pv;
			$blue = $qv;
		} else {
			die('Invalid HSV -> RGB conversion.')
		}
	}

	return Graphics::Color::RGB->new(
		red => $red, green => $green, blue => $blue
	);
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::HSV - HSV color space

=head1 DESCRIPTION

Graphics::Color::HSV represents a Color in an RGB color space.  HSLV stands for
B<Hue> B<Saturation> and B<Value>.  HSV is closely related to HSL.

=head1 SYNOPSIS

    use Graphics::Color::HSV;

    my $color = Graphics::Color::HSV->new({
        hue         => 120,
        saturation  => .5
        value   	=> .25,
    });

=head1 METHODS

=head2 Constructor

=over 4

=item new

Creates a new Graphics::Color::HSV.

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

=item I<value>

=item I<v>

Set/Get the value component of this Color.

=item I<alpha>

Set/Get the alpha component of this Color.

=item I<name>

Get the name of this color.  Only valid if the color was created by name.

=item I<as_string>

Get a string version of this Color in the form of
HUE,SATURATION,VALUE,ALPHA.

=item I<as_percent_string>

Return a percent formatted value for this color.  This format is suitable for
CSS HSV values.

=item I<as_array>

Get the HSV values as an array

=item I<as_array_with_alpha>

Get the HSVA values as an array

=item I<to_rgb>

Creates this HSV color in RGB space.  Returns a L<Graphics::Color::RGB> object.

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<<a href="http://en.wikipedia.org/wiki/HSL_and_HSV">Wikipedia</a>>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
