package Courgette::Step;

use Moose;

use vars qw( %steps );

use Data::Dumper;

has 'name' => (
  is => 'rw',
  isa => 'Str'
);

has 'block' => (
  is => 'rw',
  isa => 'CodeRef'
);

sub BUILD {
  my $self = shift;
  $steps{ $self->name } = $self;
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
