use strict;
use warnings;

package URI::cpan::distfile;
use parent qw(URI::cpan);
# ABSTRACT: cpan:///distfile/AUTHOR/Dist-1.234.tar.gz

use Carp ();
use CPAN::DistnameInfo;

=head1 SYNOPSIS

This URL refers to a file in an author directory on the CPAN, and expects the
format AUTHOR/DISTFILE

=head1 METHODS

=cut

sub validate {
  my ($self) = @_;

  my (undef, undef, $author, $filename) = split m{/}, $self->path, 4;

  Carp::croak "invalid cpan URI: invalid author part in $self"
    unless $author =~ m{\A[A-Z][-0-9A-Z]*\z};
}

=head1 dist_name

This returns the name of the dist, like F<CGI.pm> or F<Acme-Drunk>.

=cut

sub dist_name {
  my ($self) = @_;
  my $dist = CPAN::DistnameInfo->new($self->_p_rel);
  my $name = $dist->dist;

  $name =~ s/-undef$// if ! defined $dist->version;

  return $name;
}

=head1 dist_version

This returns the version of the dist, or undef if the version can't be found or
is the string "undef"

=cut

sub dist_version {
  my ($self) = @_;
  CPAN::DistnameInfo->new($self->_p_rel)->version;
}

=head1 author

This returns the name of the author whose file is referred to.

=cut

sub author {
  my ($self) = @_;
  my ($author) = $self->_p_rel =~ m{^([A-Z]+)/};
  return $author;
}

1;
