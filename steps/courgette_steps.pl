
Given "the courgette application is installed", sub {
  1;
};

When "courgette is run with the option --help", sub {
#   return $courgette_output = `bin/courgette --help`;
  return "Courgette has been run";
};


Then "help information should be displayed", sub {
  is( $courgette_output, "..." );
};

1;

