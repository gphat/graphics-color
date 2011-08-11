package Graphics::Color::CMYK;
use Moose;
use MooseX::Aliases;

extends qw(Graphics::Color);

# ABSTRACT: CMYK color model

use Graphics::Color::Types qw(Number360OrLess NumberOneOrLess);
use Graphics::Color::RGB;

=head1 DESCRIPTION

Graphics::Color::CMYK represents a Color in CMYK color model.  Cyan stands for
B<Cyan> B<Magenta> B<Yellow> B<Key> (or black).

=head1 SYNOPSIS

    use Graphics::Color::CMYK;

    my $color = Graphics::Color::CMYK->new({
        cyan    => 120,
        magenta => .5,
        yellow  => .25,
        key     => .5
    });

=attr cyan

=attr c

Set/Get the cyan component of this Color.

=cut

has 'cyan' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'c'
);

=attr magenta

=attr m

Set/Get the magenta component of this Color.

=cut

has 'magenta' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'm'
);

=attr yellow

=attr y

Set/Get the yellow component of this Color.

=cut

has 'yellow' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'y'
);

=attr key

=attr k

Set/Get the key (black) component of this Color.

=cut

has 'key' => (
    is => 'rw',
    isa => NumberOneOrLess,
    default => 1,
    alias => 'k'
);

=attr name

Get the name of this color.  Only valid if the color was created by name.

=cut

has 'name' => ( is => 'rw', isa => 'Str' );

=method as_string

Get a string version of this Color in the form of:

CYAN,MAGENTA,YELLOW,KEY

=cut

sub as_string {
    my ($self) = @_;

    return sprintf('%0.2f,%0.2f,%0.2f,%0.2f',
        $self->cyan, $self->magenta, $self->yellow, $self->key
    );
}

=method as_percent_string

Return a percent formatted value for this color.

=cut

sub as_percent_string {
    my ($self) = @_;

    return sprintf("%d%%, %d%%, %d%%, %d%%",
        $self->cyan * 100, $self->magenta * 100, $self->yellow * 100,
        $self->key * 100
    );
}

=method as_array

Get the CMYK values as an array

=cut

sub as_array {
    my ($self) = @_;

    return ($self->cyan, $self->magenta, $self->yellow, $self->key);
}

=method equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=method not_equal_to

The opposite of C<equal_to>.

=cut

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