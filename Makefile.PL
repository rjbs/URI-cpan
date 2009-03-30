use 5.006; # warnings
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME  => 'URI::cpan',
  VERSION_FROM  => 'lib/URI/cpan.pm',
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM => {
    'URI'         => 0, # minimum version
  },
  (eval { ExtUtils::MakeMaker->VERSION(6.46) }
    ? (META_MERGE => {
        resources => {
          repository => 'http://github.com/rjbs/uri-cpan'
        }
      })
    : ()
  ),
);

