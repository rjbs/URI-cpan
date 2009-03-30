use strict;
use warnings;

package URI::cpan;
use base qw(URI::_generic);
use Carp ();

use URI::cpan::author;
use URI::cpan::dist;
use URI::cpan::package;

my %type_class = (
  author   => 'URI::cpan::author',
  distfile => 'URI::cpan::distfile',

  # These will be uncommented when we figure out what the heck to do with them.
  # -- rjbs, 2009-03-30
  #
  # dist    => 'URI::cpan::dist',
  # package => 'URI::cpan::package',
  # module  => 'URI::cpan::module',
);

sub _init {
  my $self = shift->SUPER::_init(@_);
  my $class = ref($self);

  # In the future, we'll want to support "private" CPAN.  Probably when that
  # happens we will want to assert $self->authority eq $self->host.
  # -- rjbs, 2009-03-29
  Carp::croak "invalid cpan URI: non-empty authority not yet supported"
    if $self->authority;

  Carp::croak "invalid cpan URI: non-empty query string not supported"
    if $self->query;

  Carp::croak "invalid cpan URI: non-empty fragment string not supported"
    if $self->fragment;

  my (undef, @path_parts) = split m{/}, $self->path;
  my $type = $path_parts[0];

  Carp::croak "invalid cpan URI: do not understand path " . $self->path
    unless my $new_class = $type_class{ $type };

  bless $self => $new_class;

  $self->validate;

  return $self;
}

sub _p_rel {
  my ($self) = @_;
  my $path = $self->path;
  $path =~ s{^/\w+/}{};
  return $path;
}

1;
