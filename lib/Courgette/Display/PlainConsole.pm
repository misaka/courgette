package Courgette::Display::PlainConsole;

sub feature {
  my $class = shift;
  my $name = shift;

  print( "Running feature: " . $name . "\n" );
}

1;
