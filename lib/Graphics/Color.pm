package Graphics::Color;
use Moose;
use Moose::Util::TypeConstraints;

with 'MooseX::Clone';

our $AUTHORITY = 'cpan:GPHAT';
our $VERSION = '0.04';

subtype 'Number360OrLess'
    => as 'Num',
    => where { $_ <= 360 && $_ >= 0 },
    => message { "This number ($_) is not less than or equal to 360!" };

subtype 'NumberOneOrLess'
    => as 'Num',
    => where { $_ <= 1 && $_ >= 0 },
    => message { "This number ($_) is not less or equal to one!" };

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
