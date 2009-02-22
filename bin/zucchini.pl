#!/usr/bin/env perl

use lib qw{ lib };
use vars qw( $logger );

use Error qw( :try );

use Getopt::Long;
use Zucchini;
# use Zucchini::World;
use Zucchini::Feature;
use Zucchini::Logger;
use Zucchini::Step;
use Data::Dumper;
use Cwd 'abs_path';

sub parse_args {
  my @args = @_;
  my @files = @args;

  return @files;
}


sub display_missing_step {
  my $step = shift;

  print( "Step not defined: $step\n" );
}


sub run_given_step {
  my $step_name = shift;

  run_step( 'given', $step_name );
}


sub run_when_step {
  my $step_name = shift;

  run_step( 'given', $step_name );
}


sub run_then_step {
  my $step_name = shift;

  run_step( 'given', $step_name );
}


sub run_step {
  my $step_type = shift;
  my $step_name = shift;

  $logger->info( "Running $step_type step: " . $step_name );

  my( $step, $params ) = Zucchini::Step->find( $step_name );
  if ( $step ) {
    try {
      $step->run( @$params );
    } catch Error with {
      my $err = shift;
      $logger->error( "Error running $step_type $step_name\n" . $err->stringify );
    };
  } else {
    display_missing_step( $step_name );
  }
}


sub run {
  my @args = @_;
  my @stories = parse_args( @args );
  $logger = $Zucchini::logger = Zucchini::Logger->new();

  push( @Zucchini::steps_paths, abs_path( 'steps' ) );
  Zucchini::load_steps;

  foreach $filename ( @ARGV ) {
    my @features = Zucchini::Feature->load_from_file( $filename );

    foreach my $feature ( @features ) {

      $logger->info( "Running story: " . $feature->{ name } );
      foreach my $description_line ( @{ $feature->{ description } } ) {
# 	print( $description_line . "\n" );
      }

      foreach my $scenario ( @{ $feature->{ scenarios } } ) {
	$logger->info( "Running scenario: " . $scenario->{ name } );

	foreach my $given_step ( @{ $scenario->{ given } } ) {
	  run_given_step( $given_step );
	}
	foreach my $when_step ( @{ $scenario->{ when } } ) {
	  run_when_step( $when_step );
	}
	foreach my $then_step ( @{ $scenario->{ then } } ) {
	  run_then_step( $then_step );
	}

      }

    }

  }

}

# Hook up our runner here.
if( __PACKAGE__ eq 'main' ) {
  run( @ARGV );
}

