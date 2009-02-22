
package Zucchini::Logger;

use DateTime;

use Data::Dumper;

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

  $self->level( $settings{ level } || 'WARNING' );
  $self->output_handle( $settings{ output_handle } || STDERR );
}


sub level {
  my $self = shift;
  my( $new_level ) = shift;

  if( defined( $new_level ) ) {
    my( $old_level ) = $self->{ level };
    $self->{ level } = $new_level;
    return( $old_level );
  } else {
    return( $self->{ level } );
  }
}


sub output_handle {
  my $self = shift;
  my( $new_handle ) = shift;

  if( defined( $new_handle ) ) {
    my( $old_handle ) = $self->{ output_handle };
    $self->{ output_handle } = $new_handle;
    return( $old_handle );
  } else {
    return( $self->{ output_handle } );
  }
}


sub format_and_print {
  my $self = shift;
  my $level = shift;
  my $msg  = shift;
  my( @args ) = @_;

  chomp( $msg );
  $msg = sprintf(
    "%s %s $msg\n",
    DateTime->now->strftime( "%F %T" ),
    $level,
    @args
  );
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

