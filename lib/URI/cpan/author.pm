use strict;
use warnings;

package URI::cpan::author;
use base qw(URI::cpan);

our $VERSION = '1.000';

sub validate {
  my ($self) = @_;

  my ($author, @rest) = split m{/}, $self->_p_rel;

  Carp::croak "invalid cpan URI: trailing path elements in $self" if @rest;

  Carp::croak "invalid cpan URI: invalid author part in $self"
    unless $author =~ m{\A[A-Z]+\z};
}

sub author {
  my ($self) = @_;
  my ($author) = split m{/}, $self->_p_rel;
  return $author;
}

1;
