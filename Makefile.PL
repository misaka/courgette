use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Courgette',
    VERSION_FROM      => 'lib/Courgette.pm', # finds $VERSION
    PREREQ_PM         => {
      Test::Assert => 0.05
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Courgette.pm', # retrieve abstract from module
       AUTHOR         => 'Misha Gorodnitzky <misaka@pobox.com>') : ()),
    EXE_FILES         => [ 'bin/courgette' ]
);
