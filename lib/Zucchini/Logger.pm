
package Zucchini::Logger;

use constants FATAL   => 0,
              ERROR   => 1,
              WARNING => 2,
              INFO    => 3,
              DEBUG   => 4;

sub new {
  my( $class ) = shift;
  my( %settings ) = @_;
  my( $self ) = {};

  bless( $self, $class );
  $self->initialize( %settings );
  return( $self );
}

sub initialize {
  my( $self ) = shift;
  my( %settings ) = @_;

  $self->{ level         } = $settings{ level }         || INFO;
  $self->{ output_handle } = $settings{ output_handle } || STDERR;
}

sub level {
  my( $self ) = shift;
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
  my( $self ) = shift;
  my( $new_handle ) = shift;

  if( defined( $new_handle ) ) {
    my( $old_handle ) = $self->{ output_handle };
    $self->{ output_handle } = $new_handle;
    return( $old_handle );
  } else {
    return( $self->{ output_handle } );
  }
}


sub fatal {
  my( $self ) = shift;
  my( $msg ) = shift;

  print( $self->output_handle $msg ) if( $self->level >= FATAL );
}

sub error {
  my( $self ) = shift;
  my( $msg ) = shift;

  print( $self->output_handle $msg ) if( $self->level >= ERROR );
}

sub warning {
  my( $self ) = shift;
  my( $msg ) = shift;

  print( $self->output_handle $msg ) if( $self->level >= WARNING );
}

sub info {
  my( $self ) = shift;
  my( $msg ) = shift;

  print( $self->output_handle $msg ) if( $self->level >= INFO );
}

sub debug {
  my( $self ) = shift;
  my( $msg ) = shift;

  print( $self->output_handle $msg ) if( $self->level >= DEBUG );
}


1;

