
use FileHandle;

package Zucchini::Story;

use vars qw( $story_grammar %stories );

use Parse::RecDescent;
use Data::Dumper;

$::RD_HINT = 1;

$story_grammar = q{
story : story_description scenario(s)
  {
    {
      name        => $item{ story_description }[0],
      description => $item{ story_description }[1],
      scenarios   => $item{ 'scenario(s)' }
    }
  }

story_description : story_title story_stanza
  {
    [ $item{ story_title }, $item{ story_stanza } ]
  }

story_title : story_word text

story_word : ( /story:/i | /feature:/i )

story_stanza : story_stanza_line(s)

story_stanza_line : ...! scenario_word text

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

spaces : /[ \t]+/

};

sub new {
  my $class = shift;
  my $filename = shift;

  my $parser = Parse::RecDescent->new( $story_grammar );

  my $file = FileHandle->new( $filename );
  if( !defined( $file ) ) {
    die( "could not open story file '$filename': $!" );
  }

  my $original_RS = undef( $/ );
  my $story = $file->getline();
  my $self = $parser->story( $story );

  $file->close;
  $/ = $original_RS;

  bless( $self, $class );
  return $self;
}

sub logger {
  my( $self ) = shift;
  my( $new_logger ) = shift;

  if( defined( $new_logger ) ) {
    my( $old_logger ) = $self->{ logger };
    $self->{ logger } = $new_logger;
    return( $old_logger );
  } elsif( !defined( $self->{ logger } ) ) {
    $self->{ logger } = Zucchini::Logger->new;
    return( $self->{ logger } );
  } else {
    return( $self->{ logger } );
  }
}


1;
