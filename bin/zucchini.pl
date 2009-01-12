#!/usr/bin/env perl

use Getopt::Long;
use Zucchini::World;
use Zucchini::Story;

Zucchini::World::load_from( "steps/pstories_steps.pl" );

# TODO: Verify the story parseing here, but the grammar should be complete.
# TODO: Look at how we run the steps from here.

foreach $filename ( @ARGV ) {
  $story = Zucchini::Story->new( $filename );
}


# $storyFile = "stories/test.story";
# $storyFH = open( "<$storyFile" ) or die( "Could not open file $storyFile: $!" );


