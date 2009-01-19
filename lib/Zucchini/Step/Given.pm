
use Zucchini::Step;

package Zucchini::Step::Given;

sub new {
  my $class = shift;
  my $pre_condition = shift;
  my $block = shift;

  return bless( {
    pre_condition => $pre_condition,
    block         => $block
   }, $class );
}

1;
