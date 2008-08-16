package Graphics::Color;
use Moose;
use Moose::Util::TypeConstraints;

with qw(MooseX::Clone Graphics::Color::Equal);

our $AUTHORITY = 'cpan:GPHAT';
our $VERSION = '0.09';

subtype 'Graphics::Color::Number360OrLess'
    => as 'Num',
    => where { $_ <= 360 && $_ >= 0 },
    => message { "This number ($_) is not less than or equal to 360!" };

subtype 'Graphics::Color::NumberOneOrLess'
    => as 'Num',
    => where { $_ <= 1 && $_ >= 0 },
    => message { "This number ($_) is not less or equal to one!" };

sub derive {
    my ($self, $args) = @_;

    return unless ref($args) eq 'HASH';
    my $new = $self->clone;
    foreach my $key (keys %{ $args }) {
        $new->$key($args->{$key}) if($new->can($key));
    }
    return $new;
}

sub equal_to {
    die("Override me!");
}

__PACKAGE__->meta->make_immutable;

no Moose;
1;
__END__

=head1 NAME

Graphics::Color - Device and library agnostic color spaces.

=head1 SYNOPSIS

Graphics color is a device and library agnostic system for creating and
manipulating colors in various color spaces.

  my $color = Graphics::Color::RGB->new(
      red => .5, green => .5, blue => .5, alpha => .5
  );
  say $color->as_string();

=head1 DISCLAIMER

I'm not an art student or a wizard of arcane color knowledge.  I'm a normal
programmer with a penchant for things graphical.  Hence this module is likely
incomplete in some places.  Patches are encouraged.  I've intentions of adding
more color spaces as well as conversion routines (where applicable).

=head1 COLOR TYPES

The following color types are supported.

L<CMYK|Graphics::Color::CMYK>

L<HSL|Graphics::Color::HSL>

L<RGB|Graphics::Color::RGB>

L<YIQ|Graphics::Color::YIQ>

L<YUV|Graphics::Color::YUV>

=head1 METHODS

=over 4

=item I<new>

Makes a new, useless Graphics::Color object. There's no reason to do this.

=item I<derive>

Clone this color but allow one of more of it's attributes to change by passing
in a hashref of options:

  my $new = $color->derive({ attr => $newvalue });
  
The returned color will be identical to the cloned one, save the attributes
specified.

=item I<equal_to>

Compares this color to the provided one.  Returns 1 if true, else 0;

=item I<not_equal_to>

The opposite of equal_to.

=back

=head1 AUTHOR

Cory G Watson, C<< <gphat@cpan.org> >>

Infinity Interactive, L<http://www.iinteractive.com>

=head1 BUGS

Please report any bugs or feature requests to C<bug-graphics-color at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Graphics-Color>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2008 Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
