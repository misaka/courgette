package Courgette;

use 5.008008;
use strict;
use warnings;

use vars qw( $verbosity );

use Courgette::World;

use Error qw( :try );
use File::Find;

use Data::Dumper;

our $VERSION = '0.01';

use vars qw/ $logger %steps @steps_paths /;


sub verbose {
  my $msg = shift;

  chomp( $msg );
  print( $msg . "\n" ) if( $verbosity && $verbosity > 0 );
}


sub debug {
  my $msg = shift;

  chomp( $msg );
  print( $msg . "\n" ) if( $verbosity && $verbosity > 1 );
}


sub load_steps {
  find( \&load_from, @steps_paths );
}


sub load_from {
  my $filename = $File::Find::name;

  debug( "examining steps file: $filename" );

  if( ! -f $filename ) {
    debug( "not a file: $filename" );
    return;
  }

  if( ! -f $filename ) {
    debug(
      "file does not match steps pattern '$Courgette::steps_filename_pattern':"
      . " $filename"
    );
    return;
  }

  verbose( "loading steps file: $filename" );
  try {
    Courgette::World::_load_steps_file( $filename );
  } catch Error with {
    my $err = shift;
    die( "Error loading steps from '$filename': " . $err->stringify );
  };
}


# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Courgette - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Courgette;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Courgette, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Misha Gorodnitzky, E<lt>misha@migcan.priE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Misha Gorodnitzky

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
