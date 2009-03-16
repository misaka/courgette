package Courgette::Display::PlainConsole;

use base qw( Courgette::Display );

sub new {
  my $class = shift;

  bless( {}, $class );
}

sub feature {
  my $self = shift;
  my $name = shift;

  print( "Feature: " . $name . "\n" );
}

sub description {
  my $self = shift;
  my $name = shift;

  print( "\t$name\n" );
}

sub step_missing {
  my $self = shift;
  my $name = shift;

  print( "Missing code for step: $name\n" );
}

sub step_failed {
  my $self = shift;
  my $name = shift;
  my $err  = shift;

  print( "Step '$name' failed: " . $err->stacktrace );
}

1;
