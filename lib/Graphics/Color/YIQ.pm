package Graphics::Color::YIQ;
use Moose;
use MooseX::Aliases;

extends qw(Graphics::Color);

# ABSTRACT: YIQ color space

=head1 DESCRIPTION

Graphics::Color::YIQ represents a Color in an YIQ color space.

=head1 SYNOPSIS

    use Graphics::Color::YIQ;

    my $color = Graphics::Color::YIQ->new({
        luminance   => 0.5,
        in_phase    => .5
        quadrature  => .25,
    });

=begin :prelude

=head1 DISCLAIMER

I couldn't find clear information on the bounds of each value, so at the
moment there are none.

=end :prelude

=attr luminance

=attr y

Set/Get the luminance component of this Color.

=cut

has 'luminance' => (
    is => 'rw',
    isa => 'Num',
    default => 1,
    alias => 'y'
);

=attr in_phase

=attr i

Set/Get the in_phase component of this Color.

=cut

has 'in_phase' => (
    is => 'rw',
    isa => 'Num',
    default => 1,
    alias => 'i'
);

=attr quadrature

=attr q

Set/Get the quadrature component of this Color.

=cut

has 'quadrature' => (
    is => 'rw',
    isa => 'Num',
    default => 1,
    alias => 'q'
);

=attr name

Get the name of this color.  Only valid if the color was created by name.

=cut

has 'name' => ( is => 'rw', isa => 'Str' );

=method as_string

Get a string version of this Color in the form of
LUMINANCE,IN-PHASE,QUADRATURE

=cut

sub as_string {
    my ($self) = @_;

    return sprintf('%s,%s,%s',
        $self->luminance, $self->in_phase, $self->quadrature
    );
}

=method as_array

Get the YIQ values as an array

=cut

sub as_array {
    my ($self) = @_;

    return ($self->luminance, $self->in_phase, $self->quadrature);
}

=method equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=cut

sub equal_to {
    my ($self, $other) = @_;

    return 0 unless defined($other);

    unless($self->luminance == $other->luminance) {
        return 0;
    }
    unless($self->in_phase == $other->in_phase) {
        return 0;
    }
    unless($self->quadrature == $other->quadrature) {
        return 0;
    }

    return 1;
}

=attr not_equal_to

The opposite of equal_to.

=cut

__PACKAGE__->meta->make_immutable;
no Moose;
1;