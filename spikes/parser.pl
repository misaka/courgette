#!/usr/bin/env perl

use Parse::RecDescent;
use Data::Dumper;

$::RD_HINT = 1;

use vars qw{ %stories %scenarios };


# TODO: Figure out how to get the parser to be non-greedy so that it will
#       parse the scenarios instead of just treating them as a part of the
#       story description.
my $grammar = q{

story : story_description scenario(s)

story_description : story_line story_stanza
        { $main::stories{ $item{ story_line } } = $item{ story_stanza } }

story_line : /story:/i story_title

story_title : text

story_stanza : indented_line(s)

scenario : scenario_line scenario_stanza
  {
    $main::scenarios{ $item{ scenario_line } } = $item{ scenario_stanza }
  }

scenario_line : /scenario:/i text

scenario_stanza : given_line and_given_line(s?)
                  when_line and_when_line(s?)
                  then_line and_then_line(s?)
  {
    {
      Given => [ $item{ given_line }, $item{ and_given_line } ],
      When  => [ $item{ when_line },  $item{ and_when_line } ],
      Then  => [ $item{ then_line },  $item{ and_then_line } ]
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

my $story = q{
Story: Using Zucchini

       As a developper
       I want to use the PStory runner
       So that I can use stories to test my application

Scenario: Getting command-line help.

	  Given the pstory application is installed
	  When pstory is run with the option --help
          Then help information should be displayed

};


my $parser = Parse::RecDescent->new( $grammar );

my $result = $parser->story( $story );

print( Dumper( \%stories ) );
print( Dumper( $result ) );

my $scenario_result = $parser->scenario( $story );

print( Dumper( \%scenarios ) );

my $p2 = Parse::RecDescent->new( q{
blah : /^ +/ word

word : /.+/
} );

my $r2 = $p2->blah( q{
        Blah
} );

print( Dumper( $r2 ) );

