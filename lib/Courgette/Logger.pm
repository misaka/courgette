
package Courgette::Logger;

use DateTime;

use Data::Dumper;

use Courgette::Utils qw( attr_accessor );

use base qw( Courgette::Utils );
use vars qw( %levels );

%levels = (
  FATAL   => 0,
  ERROR   => 1,
  WARNING => 2,
  INFO    => 3,
  DEBUG   => 4
);


sub new {
  my( $class ) = shift;
  my( %settings ) = @_;
  my $self = {};

  bless( $self, $class );
  $self->initialize( %settings );
  return( $self );
}


sub initialize {
  my $self = shift;
  my( %settings ) = @_;

  $self->set_level( $settings{ level } || 'WARNING' );
  $self->set_output_handle( $settings{ output_handle } || STDERR );
}


attr_accessor 'level';
attr_accessor 'output_handle';
attr_accessor 'appname';


sub format_and_print {
  my $self = shift;
  my $level = shift;
  my $msg  = shift;
  my( @args ) = @_;

  chomp( $msg );
  # If we ever want to add date/time. it might look like this:
  #   DateTime->now->strftime( "%F %T" ),
  $msg = sprintf(
    "[%s] $msg\n",
    $level,
    @args
  );

  $msg = $self->get_appname . ': ' . $msg
      if( $self->get_appname );

  $self->get_output_handle->print( $msg );
}

sub fatal {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->get_level } >= $levels{ 'FATAL' } ) {
    $self->format_and_print( 'FATAL', $msg );
  }
}

sub error {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->get_level } >= $levels{ 'ERROR' } ) {
    $self->format_and_print( 'ERROR', $msg );
  }
}

sub warning {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->get_level } >= $levels{ 'WARNING' } ) {
    $self->format_and_print( 'WARNING', $msg );
  }
}

sub info {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->get_level } >= $levels{ 'INFO' } ) {
    $self->format_and_print( 'INFO', $msg );
  }
}

sub debug {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->get_level } >= $levels{ 'DEBUG' } ) {
    $self->format_and_print( 'DEBUG', $msg );
  }
}


1;

