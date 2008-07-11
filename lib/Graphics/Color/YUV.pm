package Graphics::Color::YUV;
use Moose;

extends qw(Graphics::Color);

has 'luma' => ( is => 'rw', isa => 'NumberOneOrLess', default => 0 );
has 'blue_luminance' => ( is => 'rw', isa => 'NumberOneOrLess', default => 0 );
has 'red_luminance' => ( is => 'rw', isa => 'NumberOneOrLess', default => 0 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('y' => __PACKAGE__->can('luma'));
__PACKAGE__->meta->alias_method('u' => __PACKAGE__->can('blue_luminance'));
__PACKAGE__->meta->alias_method('v' => __PACKAGE__->can('red_luminance'));

sub as_string {
    my ($self) = @_;

    return sprintf('%s,%s,%s',
        $self->luma, $self->blue_luminance, $self->red_luminance
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->luma, $self->blue_luminance, $self->red_luminance);
}

# TODO RGB Conversion
# OLD STYLE : Y' = 0.299R + 0.587G + 0.114B
# NEW STYLE: Y' = 0.2125R + 0.7154G + 0.0721B
# U = B - Y'
# V = R - Y'
#
# http://www.fourcc.org/fccyvrgb.php

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::YUV

=head1 DESCRIPTION

Graphics::Color::YUV represents a Color in an Y'UV color space.

=head1 SYNOPSIS

    use Graphics::Color::YUV;

    my $color = Graphics::Color::YUV->new({
        luma            => .5,
        blue_luminance  => .5
        red_luminance   => .25,
    });

=head1 METHODS

=head2 Constructor

=over 4

=item I<new>

Creates a new Graphics::Color::YUV.

=back

=head2 Instance Methods

=over 4

=item I<luma>

=item I<y>

Set/Get the luma (Y') component of this Color.  Aliased to y.

=item I<blue_luminance>

=item I<u>

Set/Get the blue_luminance component of this Color. Aliased to u.

=item I<red_luminance>

=item I<v>

Set/Get the red_luminance component of this Color. Aliased to v.

=item I<name>

Get the name of this color.  Only valid if the color was created by name.

=item I<as_string>

Get a string version of this Color in the form of
LUMA,BLUE_LUMINENCE,RED_LUMINANCE

=item I<as_array>

Get the YUV values as an array

=back

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1), L<Wikipedia|http://en.wikipedia.org/wiki/YUV>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
