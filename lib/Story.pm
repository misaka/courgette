
use FileHandle;

package Zucchini::Story;

use vars qw( $story_grammar );

$story_grammar = q {
story : story_line story_stanza scenario(s)

story_line : /story:/i space(s) story_description

story_description : any_character(s) eol

story_stanza : indented_line(s)

scenario : scenario_line scenario_stanza

scenario_line : /scenario:/i space(s) scenario_description

scenario_stanza

indented_line : space(s) any_character(s) eol

any_character : /[^\n]/

space : /[ \t]/

eol : /\n/

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

  while( $story =~ m/ \n \s* Story: [ \t]* ([^\n]+) \n /xg ) {
    my $title = $1;

    print( "$1\n" );
    # TODO: Find a decent parsing CPAN module to use here.
  }

  $file->close;
  $/ = $original_RS;
}


1;
