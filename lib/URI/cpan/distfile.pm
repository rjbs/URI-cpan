use strict;
use warnings;

package URI::cpan::distfile;
use base qw(URI::cpan);

use Carp ();
use CPAN::DistnameInfo;

sub validate {
  my ($self) = @_;

  my (undef, undef, $author, $filename, @rest) = split m{/}, $self->path;

  Carp::croak "invalid cpan URI: trailing path elements in $self" if @rest;

  Carp::croak "invalid cpan URI: invalid author part in $self"
    unless $author =~ m{\A[A-Z]+\z};
}

sub dist_name {
  my ($self) = @_;
  my $dist = CPAN::DistnameInfo->new($self->_p_rel);
  my $name = $dist->dist;

  $name =~ s/-undef$// if ! defined $dist->version;

  return $name;
}

sub dist_version {
  my ($self) = @_;
  CPAN::DistnameInfo->new($self->_p_rel)->version;
}

sub author {
  my ($self) = @_;
  my ($author) = $self->_p_rel =~ m{^([A-Z]+)/};
  return $author;
}

1;
