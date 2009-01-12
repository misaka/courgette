
use FileHandle;

package Zucchini::Story;

use vars qw( $story_grammar %stories );

use Parse::RecDescent;
use Data::Dumper;

$story_grammar = q{
story : story_description scenario(s)
        {
          $main::scenarios{ $item{ story_description } } = $item{ 'scenario(s)' }
        }

story_description : story_line story_stanza
        { $main::stories{ $item{ story_line } } = $item{ story_stanza };
          $item{ story_line } }

story_line : /story:/i story_title

story_title : text

story_stanza : indented_line(s)

scenario : scenario_line scenario_stanza
  {
    { $item{ scenario_line } => $item{ scenario_stanza } }
  }

scenario_line : /scenario:/i text

scenario_stanza : given_line and_given_line(s?)
                  when_line and_when_line(s?)
                  then_line and_then_line(s?)
  {
    {
      Given => [ $item{ given_line }, @{ $item{ 'and_given_line(s?)' } } ],
      When  => [ $item{ when_line },  @{ $item{ 'and_when_line(s?)' } } ],
      Then  => [ $item{ then_line },  @{ $item{ 'and_then_line(s?)' } } ]
    };
  }

given_line : /given/i text

when_line : /when/i text

then_line : /then/i text

and_given_line : and_line

and_when_line : and_line

and_then_line : and_line

and_line : /and/i text

indented_line : <skip:'\n*'> spaces text

text : /[^\n]+/

spaces : /[ \t]+/

};

sub new {
  my $class = shift;
  my $filename = shift;

  my $file = FileHandle->new( $filename );
  if( !defined( $file ) ) {
    die( "could not open story file '$filename': $!" );
  }

  my $original_RS = undef( $/ );
  my $story = $file->getline();
  my $result = $parser->story( $story );

  $file->close;
  $/ = $original_RS;
}


1;
