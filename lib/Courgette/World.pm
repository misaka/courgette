package Courgette::World;

use 5.008008;
use strict;
use warnings;

use Moose;

use Courgette::Error::AssertFailed;

use File::Find;
use Data::Dumper;

use base 'Test::Assert';


sub _load_steps_file {
  my $filename = shift;
  my $return;

  unless( $return = do $filename ) {
    die( "Error parseing step file '$filename': $@" ) if $@;
    die( "Error loading step file '$filename': $!" ) if !defined( $return );
    die( "Step file '$filename' did not return true" ) if !$return;
  }
}


sub Given {
  my $step_name = shift;
  my $block = shift;

  Courgette::Step->new(
    name  => $step_name,
    block => $block
  );
}


sub When {
  my $step_name = shift;
  my $block = shift;

  Courgette::Step->new(
    name  => $step_name,
    block => $block
  );
}


sub Then {
  my $step_name = shift;
  my $block = shift;

  Courgette::Step->new(
    name  => $step_name,
    block => $block
  );
}


sub And {
  my $step_name = shift;
  my $block = shift;

  Courgette::Step->new(
    name  => $step_name,
    block => $block
  );
}



1;
__END__

=head1 NAME

Courgette::World - Perl package to

=head1 SYNOPSIS

  courgette STORY_FILE

=head1 DESCRIPTION

  courgette is a test story runner designed to output TAP-compatible results.
  TAP is Perl's Test Anything Protocol.

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
