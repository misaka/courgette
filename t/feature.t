# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Courgette.t'

use Data::Dumper;

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 9;
BEGIN { use_ok('Courgette::Feature') };

#########################

my $feature = Courgette::Feature->new( 't/test.feature' );
ok( $feature, 'Features file was read.' );

is( $feature->{ name }, 'Using Courgette', 'Feature name is parsed correctly.' );

is_deeply(
    $feature->{ description },
    [
     'As a developper',
     'I want to use the Courgette runner',
     'So that I can use stories to test my application'
    ],
    'Feature description is parsed correctly.'
);

ok( $feature->{ scenarios }, 'Scenario is parsed.' );

is(
    $feature->{ scenarios }->[0]->{ name },
    'Getting command-line help.',
    'Scenario 1 name is parsed correctly.'
);

is_deeply(
    $feature->{ scenarios }->[0]->{ given },
    [
     'the Courgette application is installed',
     "is in the user's path"
    ],
    "Scenario 1 given steps are parsed correctly."
);

is_deeply(
    $feature->{ scenarios }->[0]->{ when },
    [
     'courgette is run with the option --help'
    ],
    "Scenario 1 when steps are parsed correctly."
);

is_deeply(
    $feature->{ scenarios }->[0]->{ then },
    [
      'help information should be displayed'
    ],
    "Scenario 1 then steps are parsed correctly."
);



