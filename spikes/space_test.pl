#!/usr/bin/env perl

use Parse::RecDescent;
use Data::Dumper;

$::RD_HINT = 1;

use vars qw{ $spaces $line };

my $grammar = q{
line : indented_line
       { print( "Line: $item[1]\n" );
         print( "Line Items: " . join( ':', @item ) . "\n" );
       }

normal_line : chars

indented_line : <skip:'\n*'> spaces chars
       { print( "Indented Line: $item[3]\n" );
         print( "Indented Line Items: " . join( ':', @item ) . "\n" );
         $main::spaces = $item[2];
         $main::line = $item[3];
       }

chars : /.*/
#          { print( "Chars: '$item[1]'\n" );
#            print( "Chars Items: " . join( ':', @item ) . "\n" );
#          }

spaces : /\s+/
#          { print( "Spaces: '$item[1]'\n" );
#            print( "Spaces Items: " . join( ':', @item ) . "\n" );
#          }
};

my $text = q{
    This line is indented.
This line is a normal line.
};

my $parser = Parse::RecDescent->new( $grammar );
my $result = $parser->line( $text );

print( "Spaces: '$spaces'\n" );
print( "Line: '$line'\n" );

print( Dumper( $result ) );

