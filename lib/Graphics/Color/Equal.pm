package Graphics::Color::Equal;
use Moose::Role;

# ABSTRACT: Moose equality role

requires 'equal_to';

=head1 DESCRIPTION

Graphics::Color::Equal is a Moose role for equality.

=head1 SYNOPSIS

  package Graphics::Color::Foo;
  use Moose;

  with 'Graphics::Color::Equal';

  sub equal_to {
      my ($self, $other) = @_;
      
      # compare and return!
  }

=method equal_to

Implement this.

=method not_equal_to

Provided you implement C<equal_to>, this will be implemented for you!

=cut

sub not_equal_to {
    my ($self, $other) = @_;
    not $self->equal_to($other);
}

no Moose;
1;