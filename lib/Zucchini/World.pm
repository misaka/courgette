package Zucchini::World;

use Zucchini::Step::Given;

use 5.008008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Zucchini ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} }, qw( Given When Then And ) );

our @EXPORT = qw();

our $VERSION = '0.01';

use vars qw( %condition %action %outcome $last_step_type );

sub Given {
  my $condition = shift;
  my $block = shift;

  print( "Found pre-condition: $condition\n" );
  $conditions{ $condition } = $block;
  $last_step_hash = \%conditions;
}

sub When {
  my $action = shift;
  my $block = shift;

  print( "Found action: $action\n" );
  $actions{ $action } = $block;
  $last_step_hash = \%actions;
}

sub Then {
  my $outcome = shift;
  my $block = shift;

  print( "Found outcome: $outcome\n" );
  $outcomes{ $outcome } = $block;
  $last_step_hash = \%outcomes;
}

sub And {
  my $continuation = shift;
  my $block = shift;

  $last_step_hash->{ $continuation } = $block;
}


sub reset_last_step {
  $last_step_hash = undef;
}


sub load_from {
  my $filename = shift;

  require $filename;

#   my $stepsFH = open( "<$filename" )
#       or die( "Could not open steps file '$filename': $!" );

}


1;
__END__

=head1 NAME

Zucchini::World - Perl package to

=head1 SYNOPSIS

  zucchini STORY_FILE

=head1 DESCRIPTION

  zucchini is a test story runner designed to output TAP-compatible results.
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
