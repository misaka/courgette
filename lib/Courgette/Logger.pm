
package Courgette::Logger;

use Class::Singleton;
use DateTime;
use Data::Dumper;

use MooseX::Singleton;

use vars qw( $instance %levels );

%levels = (
  FATAL   => 0,
  ERROR   => 1,
  WARNING => 2,
  INFO    => 3,
  DEBUG   => 4
);


has 'level' => (
  is => 'rw',
  isa => 'Str',
  default => 'WARNING'
);

has 'appname' => (
  is => 'rw',
  isa => 'Str'
);

has 'output_handle' => (
  is => 'rw',
  default => sub { \*STDERR }
);


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
    $self->level,
    @args
  );

  $msg = $self->appname . ': ' . $msg
      if( $self->appname );

  $self->output_handle->print( $msg );
}

sub fatal {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->level } >= $levels{ 'FATAL' } ) {
    $self->format_and_print( 'FATAL', $msg );
  }
}

sub error {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->level } >= $levels{ 'ERROR' } ) {
    $self->format_and_print( 'ERROR', $msg );
  }
}

sub warning {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->level } >= $levels{ 'WARNING' } ) {
    $self->format_and_print( 'WARNING', $msg );
  }
}

sub info {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->level } >= $levels{ 'INFO' } ) {
    $self->format_and_print( 'INFO', $msg );
  }
}

sub debug {
  my $self = shift;
  my $msg  = shift;

  if( $levels{ $self->level } >= $levels{ 'DEBUG' } ) {
    $self->format_and_print( 'DEBUG', $msg );
  }
}


1;

