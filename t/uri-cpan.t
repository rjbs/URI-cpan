use strict;
use warnings;
use Test::More tests => 10;
use URI;
use URI::cpan;

{
  my $url = URI->new('cpan:///dist/RJBS/URI-cpan-1.00.tar.gz');

  isa_ok($url, 'URI::cpan::dist', 'dist with ver');
  is($url->author,       'RJBS',     "we can extract author");
  is($url->dist_name,    'URI-cpan', "we can extract dist_name");
  is($url->dist_version, '1.00',     "we can extract dist_version");
}

{
  my $url = URI->new('cpan:///dist/RJBS/URI-cpan-undef.tar.gz');

  isa_ok($url, 'URI::cpan::dist', 'dist with undef ver');
  is($url->author,       'RJBS',     "we can extract author");
  is($url->dist_name,    'URI-cpan', "we can extract dist_name");
  is($url->dist_version, undef,      "we can extract dist_version");
}

{
  my $url = URI->new("cpan:///author/RJBS");

  isa_ok($url, 'URI::cpan::author', 'author url');
  is($url->author,       'RJBS',     "we can extract author");
}
