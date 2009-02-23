package Zucchini::Step;

use vars qw( %steps );

use Data::Dumper;

sub new {
  my $class = shift;
  my %params = @_;

  die( "Name parameter not provided" ) if( !exists( $params{ name } ) );
  die( "Block parameter not provided" ) if( !exists( $params{ block } ) );

  my $self = bless( \%params, $class );

  $steps{ $params{ name } } = $self;
}


sub find {
  my $class = shift;
  my $text  = shift;

  my $step = $steps{ $text };

  if( !$step ) {
    foreach my $step_name ( keys( %steps ) ) {
      my @params = ( $text =~ $step_name );
      return( $steps{ $step_name }, \@params ) if( @params );
    }
  }
  return $step;
}


sub run {
  my $self = shift;
  my @params = @_;

  $self->{ block }->( @params );
}


1;
