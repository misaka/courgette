use Data::Dumper;

use Test::More tests => 4;
BEGIN { use_ok('Courgette::Step') };

#########################

my( $step ) = Courgette::Step->new(
  name => 'Test Step',
  block => sub { 'test result'; }
);
ok( $step, 'Step created.' );

my( $found_step ) = Courgette::Step->find( 'Test Step' );
ok( $found_step, "Step found." );

is( $found_step->run, 'test result', "Step run, result recieved." );


