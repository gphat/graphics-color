package Graphics::Color::CMYK;
use Moose;

extends qw(Graphics::Color);

use Graphics::Color::RGB;

has 'cyan' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'magenta' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'yellow' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'key' => ( is => 'rw', isa => 'Graphics::Color::NumberOneOrLess', default => 1 );
has 'name' => ( is => 'rw', isa => 'Str' );

__PACKAGE__->meta->alias_method('c' => __PACKAGE__->can('cyan'));
__PACKAGE__->meta->alias_method('m' => __PACKAGE__->can('magenta'));
__PACKAGE__->meta->alias_method('y' => __PACKAGE__->can('yellow'));
__PACKAGE__->meta->alias_method('k' => __PACKAGE__->can('key'));

sub as_string {
    my ($self) = @_;

    return sprintf('%0.2f,%0.2f,%0.2f,%0.2f',
        $self->cyan, $self->magenta, $self->yellow, $self->key
    );
}

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d%%, %d%%, %d%%, %d%%",
        $self->cyan * 100, $self->magenta * 100, $self->yellow * 100,
        $self->key * 100
    );
}

sub as_array {
    my ($self) = @_;

    return ($self->cyan, $self->magenta, $self->yellow, $self->key);
}

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->cyan == $other->cyan) {
        return 0;
    }
    unless($self->magenta == $other->magenta) {
        return 0;
    }
    unless($self->yellow == $other->yellow) {
        return 0;
    }
    unless($self->key == $other->key) {
        return 0;
    }

    return 1;
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color::CMYK - CMYK color model

=head1 DESCRIPTION

Graphics::Color::CMYK represents a Color in CMYK color model.  Cyan stands for
B<Cyan> B<Magenta> B<Yellow> B<Key> (or black).

=head1 SYNOPSIS

    use Graphics::Color::CMYK;

    my $color = Graphics::Color::CMYK->new({
        cyan    => 120,
        magenta => .5
        yellow  => .25,
        key     => .5
    });

=head1 CONSTRUCTOR

=head2 Graphics::Color::CMYK->new(%options);

Creates a new Graphics::Color::CMYK.

=head1 METHODS

=head2 cyan

=head2 c

Set/Get the cyan component of this Color.

=head2 equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=head2 not_equal_to

The opposite of C<equal_to>.

=head2 magenta

=head2 m

Set/Get the magenta component of this Color.

=head2 yellow

=head2 y

Set/Get the yellow component of this Color.

=head2 key

=head2 k

Set/Get the key (black) component of this Color.

=head2 name

Get the name of this color.  Only valid if the color was created by name.

=head2 as_string

Get a string version of this Color in the form of
CYAN,MAGENTA,YELLOW,KEY

=head2 as_percent_string

Return a percent formatted value for this color.

=head2 as_array

Get the CMYK values as an array

=head1 AUTHOR

Cory Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 SEE ALSO

perl(1) L<http://en.wikipedia.org/wiki/CMYK>

=head1 COPYRIGHT & LICENSE

Copyright 2008 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
