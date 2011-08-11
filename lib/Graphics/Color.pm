package Graphics::Color;
use Moose;
use Moose::Util::TypeConstraints;

with qw(MooseX::Clone Graphics::Color::Equal MooseX::Storage::Deferred);

# ABSTRACT: Device and library agnostic color spaces.

=head1 DESCRIPTION

Graphics color is a device and library agnostic system for creating and
manipulating colors in various color spaces.

=head1 SYNOPSIS

  my $color = Graphics::Color::RGB->new(
      red => .5, green => .5, blue => .5, alpha => .5
  );
  say $color->as_string;

=begin :prelude

=head1 DISCLAIMER

I'm not an art student or a wizard of arcane color knowledge.  I'm a normal
programmer with a penchant for things graphical.  Hence this module is likely
incomplete in some places.  Patches are encouraged.  I've intentions of adding
more color spaces as well as conversion routines (where applicable).

=head1 COLOR TYPES

The following color types are supported.

L<CMYK|Graphics::Color::CMYK>

L<HSL|Graphics::Color::HSL>

L<HSV|Graphics::Color::HSV>

L<RGB|Graphics::Color::RGB>

L<YIQ|Graphics::Color::YIQ>

L<YUV|Graphics::Color::YUV>

=end :prelude

=method derive

Clone this color but allow one of more of it's attributes to change by passing
in a hashref of options:

  my $new = $color->derive({ attr => $newvalue });
  
The returned color will be identical to the cloned one, save the attributes
specified.

=cut

sub derive {
    my ($self, $args) = @_;

    return unless ref($args) eq 'HASH';
    my $new = $self->clone;
    foreach my $key (keys %{ $args }) {
        $new->$key($args->{$key}) if($new->can($key));
    }
    return $new;
}

=method equal_to

Compares this color to the provided one.  Returns 1 if true, else 0;

=method not_equal_to

The opposite of equal_to.

=cut

sub equal_to {
    die("Override me!");
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
