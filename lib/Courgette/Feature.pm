
use FileHandle;

package Courgette::Feature;

use Moose;

use vars qw( $feature_grammar %features );

use Parse::RecDescent;
use Data::Dumper;

$::RD_HINT = 1;

has 'name' => (
  is => 'rw',
  isa => 'Str'
);

has 'description' => (
  is => 'rw',
  isa => 'ArrayRef'
);

has 'scenarios' => (
  is => 'rw',
  isa => 'ArrayRef'
);

$feature_grammar = q{
features : feature(s)

feature : feature_description scenario(s)
  {
    {
      name        => $item{ feature_description }[0],
      description => $item{ feature_description }[1],
      scenarios   => $item{ 'scenario(s)' }
    }
  }

feature_description : feature_title feature_stanza
  {
    [ $item{ feature_title }, $item{ feature_stanza } ]
  }

feature_title : feature_word text

feature_word : ( /feature:/i | /story:/i )

feature_stanza : feature_stanza_line(s)

feature_stanza_line : ...! scenario_word text

scenario : scenario_title scenario_stanza
  {
    {
      name  => $item{ scenario_title },
      given => $item{ scenario_stanza }->{ given },
      when  => $item{ scenario_stanza }->{ when  },
      then  => $item{ scenario_stanza }->{ then  }
    }
  }

scenario_title : scenario_word text

scenario_word : /scenario:/i

scenario_stanza : given_line and_given_line(s?)
                  when_line and_when_line(s?)
                  then_line and_then_line(s?)
  {
    {
      given => [ $item{ given_line }, @{ $item{ 'and_given_line(s?)' } } ],
      when  => [ $item{ when_line },  @{ $item{ 'and_when_line(s?)' } } ],
      then  => [ $item{ then_line },  @{ $item{ 'and_then_line(s?)' } } ]
    };
  }

given_line : /given/i text

when_line : /when/i text

then_line : /then/i text

and_given_line : and_line

and_when_line : and_line

and_then_line : and_line

and_line : /and/i text

text : /[^\n]+/

};

sub load_from_file {
  my $class = shift;
  my $filename = shift;

  my $parser = Parse::RecDescent->new( $feature_grammar );

  my $file = FileHandle->new( $filename );
  if( !defined( $file ) ) {
    die( "could not open feature file '$filename': $!" );
  }

  my $original_RS = undef( $/ );
  my $feature_text = $file->getline();
  my @features;

  my $parsed_features = $parser->features( $feature_text );
  die( "No features found in $filename." ) if( !$parsed_features );

  foreach my $parsed_feature ( @{ $parsed_features } ) {
    push( @features, $class->new( %$parsed_feature ) );
  }

  $file->close;
  $/ = $original_RS;

  return @features;
}


1;
